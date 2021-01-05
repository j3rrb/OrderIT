import 'package:http/http.dart' as http;

class Cities {

  String city;

  Cities({
    this.city
  });
  
  Cities.fromJson(Map<String, dynamic> json){
    city = json['city'];
  }

  Future getCities() async{
    const api_key = '67ac47595f8ae44426e22763b0d00848';
    
    const url = 'http://battuta.medunes.net/api/city/br/search/?region=parana&key=$api_key';

    return await http.get(url);
  }

}