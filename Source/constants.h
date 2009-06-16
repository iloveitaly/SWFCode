#ifdef IS_PRODUCTION
#define BASE_URL "http://www.digidecor.com/"
#else
#define BASE_URL "http://www.digidecor.com/"
#endif

// XML gen urls
#define PHP_FOLDER_NAME "framers/flash/ffphp"
#define CENTER_IMAGE_FOLDER_NAME BASE_URL + PHP_FOLDER_NAME + "/centerimages"
#define FRAME_LIST_URL BASE_URL + PHP_FOLDER_NAME + "/framelist.php"
#define LINER_LIST_URL BASE_URL + PHP_FOLDER_NAME + "/linerlist.php"
#define FILLET_LIST_URL BASE_URL + PHP_FOLDER_NAME + "/filletlist.php"
#define MAT_LIST_URL BASE_URL + PHP_FOLDER_NAME + "/matlist.php"
#define FRAME_PIECE_URL BASE_URL + PHP_FOLDER_NAME + "/framepiece.php"
#define APPLICATION_SETTINGS_URL BASE_URL + PHP_FOLDER_NAME + "/settings.php"
#define PICTURE_DATA_URL BASE_URL + PHP_FOLDER_NAME + "/picture.php"
#define MAT_CORNER_LIST_URL BASE_URL + PHP_FOLDER_NAME + "/cornerlist.php"

// action URLs
#define SCALED_IMAGE_URL BASE_URL + PHP_FOLDER_NAME + "/scaledpicture.php"
#define ADD_TO_CART_URL BASE_URL + "cart.php"

// directory paths
#define FRAME_PEICE_PREFIX BASE_URL + "frameimage/"
#define LINER_PEICE_PREFIX BASE_URL + "linerimage/"
#define FILLET_PEICE_PREFIX BASE_URL + "filletimage/"
#define MAT_PEICE_PREFIX BASE_URL + "matimage/"
#define MAT_CORNER_IMAGE_PREFIX BASE_URL + "cornerimage/"

// demension variables
#define COST_BUTTON_HEIGHT 22
#define TAB_BUTTON_HEIGHT 25
#define MENU_AREA_H 205
#define MENU_AREA_W 800
#define MENU_AREA_PADDING 10
#define MENU_GRAY_MENU_H 30
#define MENU_CONTENT_H (MENU_AREA_H - (MENU_AREA_PADDING * 2) - MENU_GRAY_MENU_H )

#define APP_DATA ApplicationData.sharedController()
#define PPI ApplicationData.sharedController().getPixelsPerInch()
#define IMG_METRICS ImageMetrics.sharedController()
#define PREVIEW_IMG_URL(__type__, __w__, __h__, __id__) SCALED_IMAGE_URL + "?t="+__type__+"&id="+__id__+"&w="+__w__+"&h="+__h__