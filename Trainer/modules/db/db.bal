import Trainer.mod;
import ballerinax/mongodb;

public class store{
    private mongodb;
    Client mongo.clt;

    public function init(module:DBconfig) returns error {
        mongodb.Clientconfig mongo.config{
            port:configport,
            host:confighost
        };
        self.mongodb = check new(mongo.config,config.dbname);
        self.mongo = config.collection
    }

    public function get Stores(string? storeName, string? foodItems, int? quantity) returns model:Store[]|error{
        nmap(json) searchquery = {
          if (storeName! = nil) {
            search.query["storeName"]="storeName";
          }
          if (foodItem! = nil) {
            search.query["foodItem"]="foodItem";
          }
          if (quantity! = nil) {
            search.query["quantity"]="quantity";
          }    
        };
    }

}