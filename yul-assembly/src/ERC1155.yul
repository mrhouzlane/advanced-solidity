/**
@author Mehdi Rhouzlane 
*/


object "ERC1155" {
     /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    /**
    *@notice Constructor to create a ERC1155 contract
    */
    code {
        function ownerSlot() -> p {p := 0}
        // p=1: balanceSlot()
        // p=2: operatorApprovalSlot()

        function uriLengthSlot() -> p {p := 3}
        
    }



}