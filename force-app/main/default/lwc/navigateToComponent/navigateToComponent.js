import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

/**
* Created by Juan Ramirez, July 26/2022
* Purpose: component to can navigate between different components
*
*/
export default class NavigateToComponent extends NavigationMixin(LightningElement) {


     /**
    * @author Juan Ramirez
    * @date 2022/07/25
    * @description navigate to specific community page
    * @param componentName destination component name
    * @param parameters it's a json object with the different parameters (each parameter is an api variable in the destination component)
    * @return 
    */
      @api
      navigateToCommunityPage(componentName, parameters){
          
         console.log('[NavigateToComponent.navigateToStandardComponent] componentName: '+componentName+' this.parameters: ' + JSON.stringify(parameters));
         this[NavigationMixin.Navigate]({
             type: 'comm__namedPage',
             attributes: {
                 'pageName': componentName
             }, 
             'state': 
                 parameters},true);
      }
}