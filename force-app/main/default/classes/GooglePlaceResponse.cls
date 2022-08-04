/* **************************************************************************
    * Class: MessageResponse
    * Created by Juan Ramirez, August 01/2022
    *
    * Purpose/Methods:
    * - class to save Google Place API Response
    *
    *
    * Modifications:
    * - {DevName}, {MM/DD/YYYY} - {Description of changes made post deployment to client}
    *
    ************************************************************************** */
    public class GooglePlaceResponse {

        public List<Candidates> candidates;
        public String status;
    
        public class Candidates {
            public String place_id;
        }
    
        
        public static GooglePlaceResponse parse(String json) {
            return (GooglePlaceResponse) System.JSON.deserialize(json, GooglePlaceResponse.class);
        }
    }
