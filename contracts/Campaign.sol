pragma solidity ^0.4.17;

contract Campaignfactory {
    // Campaign disimpan pada array dengan tipe address
    address[] public deployedCampaigns;

    // Create campaign
    function createCampaign(uint minimum,string name,string description,string image,uint target) public {
        address newCampaign = new Campaign(minimum, msg.sender,name,description,image,target);
        // Push new campaign to deployedCampaigns
        deployedCampaigns.push(newCampaign);
    }

    // Get all campaigns in deplloyedCampaigns
    function getDeployedCampaigns() public view returns (address[]) {
        return deployedCampaigns;
    }
}

contract Campaign {
    struct Request {
        // Request description
        string description;
        // Request value or amount
        uint value;
        // Requester address
        address recipient;
        // Status request [false] is not complete and [true] is complete
        bool complete;
        // Total approvals approved the request
        uint approvalCount;
        // All of approvals with status of approve
        mapping(address => bool) approvals;
    }

    // Withdraw requested
    Request[] public requests;
    // Who's create campaign
    address public manager;
    // Minimum to join as aproval
    uint public minimunContribution;
    // Campaign name
    string public CampaignName;
    // Campaign Description
    string public CampaignDescription;
    // Image Url
    string public imageUrl;
    // Campaign amount target
    uint public targetToAchieve;
    // Address of all contributers
    address[] public contributers;
    // Approvers approve status requested withdraw, address as key with bool value
    mapping(address => bool) public approvers;
    // Approvers counts
    uint public approversCount;

    // For restrict who is can access
    modifier restricted() {
        // Check sender is manager (Campaign creator)
        require(msg.sender == manager);
        _;
    }

    // Campaign model
    function Campaign(uint minimun, address creator,string name,string description,string image,uint target) public {
        manager = creator;
        minimunContribution = minimun;
        CampaignName=name;
        CampaignDescription=description;
        imageUrl=image;
        targetToAchieve=target;
    }

    function contribute() public payable {
        // Check value is higher from minimumContribution or not, is not return [false]
        require(msg.value > miniumContribution);

        contributers.push(msg.sender);
        // Set approve status by sender default is true
        approvers[msg.sender] = true;
        // Count the approvers
        approversCount++;
    }

    // Create new request
    function createRequest(string description, uint value, address recipient) public restricted {
        // New request
        Request memory newRequest = Request({
            description: description,
            value: value,
            recipient: recipient,
            // Default complete is false
            complete: false,
            // Default approvalCount is 0
            approvalCount: 0,
        });
        
        // Push new request to list of requested
        requests.push(newRequest);
    }

    function approveRequest(uint index) public {
        // Check sender is approvers or not, is not return [false]
        require(approvers[msg.sender]);
        // Check sender is approve the request or not, is approved return [false]
        require(!requests[index].approvals[msg.sender]);
        
        // Change sender approve status to [true]
        requests[index].approvals[msg.sender] = true;
        // Count total approvers who is approved [true]
        requests[index].approvalCount++;
    }

    // Finalize request by manager (Campaign creator)
    function finalizeRequest(uint index) public restricted{
        // Check total approvals who's approved the request is more than approvers total, is not return [false]
        require(requests[index].approvalCount > (approversCount / 2));
        // Check request is completed or not, is completed return false
        require(!requets[index].complete);

        // Transfer requetsed withdraw to recipient wallet with needed ether value
        requests[index].recipient.transfer(requests[index].value);
        // Change status request withdraw to [true] (the request is complete)
        requests[index].complete = true;
    }

    // Get campaign summary
    function getSummary() public view returns (uint,uint,uint,uint,address,string,string,string,uint) {
        return(
            minimunContribution,
            this.balance,
            requests.length,
            approversCount,
            manager,
            CampaignName,
            CampaignDescription,
            imageUrl,
            targetToAchieve
        );
    }

    // Get total request withdraw
    function getRequestsCount() public view returns (uint) {
        return requests.length;
    }
}