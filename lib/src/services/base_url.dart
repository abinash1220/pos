abstract class BaseApiService{
   final String baseUrl = "http://102.130.192.81:2018/WebApi/";

   //authorization api(login api url)
   final String loginUrl = "http://102.130.192.81:2018/WebApi/token";

   //customer list api url
   final String customerListUrl = "http://102.130.192.81:2018/WebApi/Base/Clientes/LstClientes";

   //create customer api url
  // final String createCustomerUrl = "http://197.234.121.208:2018/WebApi/Base/Clientes/Actualiza";

   //create items api url
   final String createItemsUrl = "http://102.130.192.81:2018/WebApi/Base/Artigos/Actualiza/";

   //items list api url
   //final String itemsListUrl = "http://197.234.121.208:2018/WebApi/Plataforma/Listas/CarregaLista/Artigo";

   //items pricelist api url
   final String priceListUrl = "http://102.130.192.81:2018/WebApi/Plataforma/Listas/CarregaLista/adhoc/";

   //invoice save api url
   final String invoiceUrl = "http://102.130.192.81:2018/WebApi/POSSales/CreatePOSDocument/";

   //list user serie api url
   final String listUserSerieUrl = "http://102.130.192.81:2018/WebApi/Plataforma/Listas/CarregaLista/adhoc/";

   //recent order api url
   final String recentOrderApiUrl = "http://102.130.192.81:2018/WebApi/Plataforma/Listas/CarregaLista/adhoc/";

   //customer list new api url
   final String customerListApiUrl = "http://102.130.192.81:2018/WebApi/Plataforma/Listas/CarregaLista/adhoc/";
   
}