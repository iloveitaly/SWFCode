//
//  ÇPROJECTNAMEÈ.as
//  ÇPROJECTNAMEÈ
//
//  Created by ÇFULLUSERNAMEÈ on ÇDATEÈ.
//  Copyright ÇORGANIZATIONNAMEÈ ÇYEARÈ . All rights reserved.
//

package {
	import flash.display.*;
	import com.mab.debug;
	
	public class ÇPROJECTNAMEÈ extends MovieClip {
		
		public static function root() : DisplayObjectContainer {
			return ÇPROJECTNAMEÈ._stage;
		}
		
		public function ÇPROJECTNAMEÈ () {
			ÇPROJECTNAMEÈ._stage = this.stage;
#ifndef IS_PRODUCTION
			debug.init(FrontSplash.root());
			debug.initSocket();
#else
			debug.disableTracing = true;
#endif
		}
	}
}