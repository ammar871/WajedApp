class Endpoints {
  static const String baseURL = "https://wajed.urapp.site";
  static const String baseURLImages = "https://wajed.urapp.site/images/";

  /// ATUH
  static const String signUp = "/signup";
  static const String checkUsername = "/check-username";
  static const String userLogin = "/user-login";

  /// CATEGORIES
  static const String addCategory = "/category/add-category";
  static const String getCategories = "/category/get-categories";
  static const String deleteCategory = "/category/delete-category";
  static const String updateCategory = "/category/update-category";

  ///
  static const String getFields = "/field/get-fields";

  /// PRODUCTS
  static const String getProducts = "/product/get-products";
  static const String getProductsByCatId = "/product/get-Products-By-Cate";
  static const String getProductById = "/product/get-Product-byId";
  static const String getProductDetails = "/product/get-Product-details";

  /// CART
  static const String addCart = "/cart/add-cart";
  static const String getCarts = "/cart/get-carts";
  static const String updateCart = "/cart/update-cart";
  static const String deleteCart = "/cart/delete-cart";

  /// PRODUCTS OPTIONS
  static const String addProductOptions = "/productOptions/add-Product-options";
  static const String getProductsOptionsByPrId =
      "/productOptions/get-Products-options-By-prId";
  static const String getProductsOptions =
      "/productOptions/get-Products-options";
  static const String deleteProductOptions =
      "/productOptions/delete-Product-options";
  static const String updateProductOptions =
      "/productOptions/update-Product-options";

  ///
  static const String uploadImage = "/image/upload/image";
  static const String addAddress = "/address/add-address";
  static const String updateAddress = "/address/update-address";
  static const String addDefaultAddress = "/address/default-address";
  static const String deleteAddress = "/address/delete-address";
  static const String getAddresses = "/address/get-addresses";
  static const String getHomeData = "/home/get-home-data";

  ///
  static const String searchMarket = "/market/search-Market";
  static const String getMarketsByFieldId = "/market/get-markets-byFieldId";

  ///
  static const String addOrder = "/orders/add-order";
  static const String getOrderDetails = "/orders/get-OrderDetails";
  static const String getOrders = "/orders/get-Orders";

  static const String addRate = "/rates/add-rate";
  static const String getAlerts = "/alerts/get-Alerts";
  static const String getAppConfigs = "/AppConfig/get-AppConfigs";
  static const updateOrderStatus = "/orders/update-Order-status";

  static const googleMapGeocode =
      "https://maps.googleapis.com/maps/api/geocode/json?";
}

class MarketEndpoints {
  static const getHomeDataProvider = "/home/get-home-data-provider";
  static const addMarket = "/market/add-Market";
  static const String getMarketDetails = "/market/get-marketDetails";
  static const String getOrdersByMarketId = "/orders/get-Orders-by-marketId";
}

class DeliveryEndpoints {
  static const getOrdersByDriverId = "/orders/get-Orders-by-driverId";
  static const acceptOrder = "/orders/accept-order-driver";
  static const updateDeviceToken = "/update-device-token";
  static const getUser = "/get-user";
}
