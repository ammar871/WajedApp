class ApiConstants {
  static const googleKey = "AIzaSyCHcAKXFZuQ8WhkAvW1zv3MTVibHU9EuF0";

  /// * =============================== . Global path
  static const baseUrl = "http://localhost:5010";
//static const baseUrl = "https://6382-154-183-206-248.ngrok-free.app";
//  static const baseUrl = "https://wajedappapi.urapp.site";
  static const baseUrlImages = "$baseUrl/images/";
  static const uploadImagesPath = "$baseUrl/image/upload/image";
  static String imageUrl(path) => baseUrlImages + path;

  /// * =============================== . AUTH path
  static const checkUserPath = "$baseUrl/check-username";
  static const loginPath = "$baseUrl/user-login";
  static const signUpPath = "$baseUrl/signup";
  static const updateDeviceTokenPath = "$baseUrl/update-device-token";
  static const deleteAccountPath = "$baseUrl/delete-accounte";

  
    /// * =============================== . Profile path
  static const getUserPath = "$baseUrl/get-user?";
  static const updateUserPath = "$baseUrl/update-user";

  /// * =============================== . Home path
  static const homeUserPath = "$baseUrl/home/get-home-data?";
  static const homeMarketPath = "$baseUrl/home/get-home-data-provider?";
  static const homeDrriverPath = "$baseUrl/home/get-home-data-driver?";

  /// * =============================== . market path

  static const marketDetailsPath = "$baseUrl/market/get-marketDetails?";
  static const getMarketsByFieldId = "$baseUrl/market/get-markets-byFieldId?";
  static const searchMarketsPath = "$baseUrl/market/search-Market";
  static const addMarketsPath = "$baseUrl/market/add-Market";
   static const updateMarketsPath = "$baseUrl/market/update-Market";
  static const getFieldsPath = "$baseUrl/field/get-fields";
static const filtersMarket = "$baseUrl/market/filters-markets";
static const getMarketsByOfferId = "$baseUrl/market/get-markets-byOfferId?";


  /// * ========================================== Category Path
 static const getCategoriesPath = "$baseUrl/category/get-categories-market?";
  static const addCategoryPath = "$baseUrl/category/add-category";
  static const updateCategoryPath = "$baseUrl/category/update-category";

    static const deleteCategoryPath = "$baseUrl/category/delete-category";
  /// * =============================== . products path
  static const productsByCategoryIdPath =
      "$baseUrl/product/get-Products-By-Cate?";
  static const productDetailsPath = "$baseUrl/product/get-Product-details?";

  static const addProductPath = "$baseUrl/product/add-Product";
  static const updateProductPath = "$baseUrl/product/update-Product";
  static const deleteProductPath = "$baseUrl/product/delete-Product";

  static const addGroupsProductPath = "$baseUrl/GroupOptions/add-Group-options";

  static const addOptionsProductPath =
      "$baseUrl/productOptions/add-Product-options";

  /// * ====================================== . driver path

  static const getDriversPath = "$baseUrl/driver/get-drivers?";
  static const addDriverPath = "$baseUrl/driver/add-driver";
  static const updateDriverPath = "$baseUrl/driver/update-driver";
  static const deleteDriverPath = "$baseUrl/driver/delete-driver";

  /// * ==================================== . alerts

  static const getAlertsPath = "$baseUrl/alerts/get-Alerts?";

  ///*  ===================================== . address path
  static const getAddressesPath = "$baseUrl/address/get-addresses?";
  static const addAddressPath = "$baseUrl/address/add-address";
  static const updateAddressPath = "$baseUrl/address/update-address";
  static const defulteAddressPath = "$baseUrl/address/default-address";
  static const deleteAddressPath = "$baseUrl/address/delete-address";

  
  ///*  ===================================== . fav path
  static const getFavesPath = "$baseUrl/fav/get-favorites?";
  static const addFavPath = "$baseUrl/fav/add-favorite";

  /// * ================================ . orders path

  static const getOrdersPath = "$baseUrl/orders/get-Orders-user?";
  static const getOrdersByMarketIdPath =
      "$baseUrl/orders/get-Orders-by-marketId?";
       static const getOrdersByDriverIdPath =
      "$baseUrl/orders/get-Orders-by-driverId?";
  static const getOrderDetailsPath = "$baseUrl/orders/get-OrderDetails?";
  static const addOrderPath = "$baseUrl/orders/add-order";
  static const reAddOrderPath = "$baseUrl/orders/re-order";
  static const updateStatusOrderPath = "$baseUrl/orders/update-Order-status";
  static const deleteOrderPath = "$baseUrl/orders/delete-Order";
  static const acceptOrderDriverPath = "$baseUrl/orders/accept-order-driver";


  // * ================================== . offers


  static const getOffersPath = "$baseUrl/offers/get-Offers?";
  

  /// * =============================== . chate path
  static const sendMessagePath = "$baseUrl/chate/add-message";
  static const getMessagesByUserIdPath =
      "$baseUrl/chate/get-messages-by-userId?";
  static const getMessagesByConvIdPath =
      "$baseUrl/chate/get-messages-by-convId?";

  static const getConvsByUserIdPath = "$baseUrl/chate/get-Convs-by-userId?";
  static const getConvByUserIdPath = "$baseUrl/chate/get-conv-by-userId?";

  ///* =============================== . notifications path

  static const getNotificationsPath =
      "$baseUrl/notification/get-notifications?UserId=";

       ///* =============================== . rates path
  static const addRatePath = "$baseUrl/rates/add-rate";

  /// * ==================================  complaints 
  static const addComplaintPath = "$baseUrl/complaints/add-complaint";

  // local Storage constants
  static const langKey = "lang";
  static const tokenKey = "token";
  static const phoneKey = "phone";
  static const userIdKey = "id";
  static const emailKey = "email";
  static const roleKey = "role";
  static const imageKey = "image";
  static const nameKey = "name";

  /// * rols

  static const client = "client";
  static const delivery = "delivery";
  static const restaurant = "restaurant";

  /// * type rates
  static const marketRate = "market";
  static const orderRate = "order";

}
