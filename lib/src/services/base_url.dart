abstract class BaseApiService{
   final String baseUrl = "http://154.71.134.210:2018/WebApi/";

   //authorization api(login api url)
   final String loginUrl = "http://154.71.134.210:2018/WebApi/token";

   //customer list api url
   final String customerListUrl = "http://154.71.134.210:2018/WebApi/Base/Clientes/LstClientes";

   //create customer api url
   final String createCustomerUrl = "http://154.71.134.210:2018/WebApi/Base/Clientes/Actualiza";

   //create items api url
   final String createItemsUrl = "http://154.71.134.210:2018/WebApi/Base/Artigos/Actualiza/";

   //items list api url
   final String itemsListUrl = "http://154.71.134.210:2018/WebApi/Plataforma/Listas/CarregaLista/Artigo";

   //items pricelist api url
   final String priceListUrl = "http://154.71.134.210:2018/WebApi/Plataforma/Listas/CarregaLista/adhoc/";

   //invoice save api url
   final String invoiceUrl = "http://154.71.134.210:2018/WebApi/Vendas/Docs/CreateDocument/";
   
}