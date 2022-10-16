// Declare types
// connfigure DB records
public type DBconfig record {|
string host;
string port;
string dbname;
string collection;
|};

// Declare customer detail
public type customerDetail record {|
string customerName;
string customerEmail;
string customerNumber;
|};

public type Store record {|
string foodItems;
int quanitity;
string storeName;
|};