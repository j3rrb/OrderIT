class User {
  String name;
  String email;
  String phoneNum;
  String city;
  String cpf;
  Map<dynamic, dynamic> payMethods;
  Map<dynamic, dynamic> orders;

  User(this.name, this.email, this.phoneNum, this.city, this.cpf, {this.payMethods, this.orders});

	get getPayMethods {
		return this.payMethods;
	}

	set setPayMethods(Map<String,dynamic> payMethods) {
		this.payMethods = payMethods;
	}

	get getOrders {
		return this.orders;
	}

	set setOrders(Map<String,dynamic> orders) {
		this.orders = orders;
	}

	String get getCpf {
		return this.cpf;
	}

	set setCpf(String cpf) {
		this.cpf = cpf;
	}

  String get getEmail {
		return this.email;
	}

	set setEmail(String email) {
		this.email = email;
	}

  String get getUsername{
    return this.name;
  }

  set setUsername(String name){
    this.name = name;
  }

  String get getCity{
    return this.city;
  }

  set setCity(String city){
    this.city = city;
  }

  String get getUserPhone{
    return this.phoneNum;
  }

  set setUserPhone(String phone){
    this.phoneNum = phone;
  }
}