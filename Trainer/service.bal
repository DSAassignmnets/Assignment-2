import ballerinax/kafka;
import ballerina/log;

// Create the kafka producer
// responsible for publishing records
kafka:ProducerConfiguration producerConfiguration = {
    clientId: "basic-producer",
    acks: "all",
    retryCount: 3
};

kafka:Producer kafkaProducer = check new (kafka:DEFAULT_URL, producerConfiguration);

// Create Kafka consumer
// responsible for reading records
kafka:ConsumerConfiguration consumerConfiguration = {
    groupId: "group-id",    // Unique string that identifies the consumer
    offsetReset: "earliest",    // Offset reset strategy if no initial offset
    topics: ["kafka-topic"]
};

kafka:Consumer kafkaConsumer = check new (kafka:DEFAULT_URL, consumerConfiguration);

// Create Kafka Listener
// Consumer used as listener to set topics
// Ise caller to manually commit messages readable by service
kafka:ConsumerConfiguration consumerConfigs = {
    groupId: "group-id",
    topics: ["kafka-topic-1"],
    pollingInterval: 1,
    autoCommit: false
};

listener kafka:Listener kafkaListener = new (kafka:DEFAULT_URL, consumerConfiguration);

service kafka:Service on kafkaListener {
    remote function onConsumerRecord(kafka:Caller caller, kafka:ConsumerRecord[] records) {
        // processes the records
        // commits the offsets manually
        kafka:Error? commitResult = caller->commit();

        if commitResult is kafka:Error {
            log:printError("Error occurred while committing the offsets for the consumer ", 'error = commitResult);
        }
    }
}
