//
//  �PROJECTNAME�.as
//  �PROJECTNAME�
//
//  Created by �FULLUSERNAME� on �DATE�.
//  Copyright �ORGANIZATIONNAME� �YEAR� . All rights reserved.
//

package {
	import flash.display.*;
	import com.mab.debug;
	
	public class �PROJECTNAME� extends MovieClip {
		
		public static function root() : DisplayObjectContainer {
			return �PROJECTNAME�._stage;
		}
		
		public function �PROJECTNAME� () {
			�PROJECTNAME�._stage = this.stage;
#ifndef IS_PRODUCTION
			debug.init(FrontSplash.root());
			debug.initSocket();
#else
			debug.disableTracing = true;
#endif
		}
	}
}