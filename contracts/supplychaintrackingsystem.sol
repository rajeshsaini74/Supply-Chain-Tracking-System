// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SupplyChainTracking {
    // Product structure to store product information
    struct Product {
        uint256 id;
        string name;
        string description;
        address manufacturer;
        address currentOwner;
        uint256 timestamp;
        ProductStatus status;
        string location;
        string batchId;
        bool exists;
    }

    // Product status enumeration
    enum ProductStatus {
        Manufactured,
        InTransit,
        Delivered,
        Recalled
    }

    // Event definitions
    event ProductRegistered(
        uint256 indexed productId,
        string name,
        address indexed manufacturer,
        string batchId
    );

    event OwnershipTransferred(
        uint256 indexed productId,
        address indexed from,
        address indexed to,
        string location
    );

    event ProductStatusUpdated(
        uint256 indexed productId,
        ProductStatus status,
        string location
    );

    // State variables
    mapping(uint256 => Product) public products;
    mapping(address => bool) public authorizedEntities;
    mapping(string => uint256[]) public batchProducts;
    
    uint256 public productCounter;
    address public admin;

    // Modifiers
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    modifier onlyAuthorized() {
        require(
            authorizedEntities[msg.sender] || msg.sender == admin,
            "Not authorized to perform this action"
        );
        _;
    }

    modifier productExists(uint256 _productId) {
        require(products[_productId].exists, "Product does not exist");
        _;
    }

    // Constructor
    constructor() {
        admin = msg.sender;
        authorizedEntities[msg.sender] = true;
    }

    /**
     * @dev Register a new product in the supply chain
     * @param _name Product name
     * @param _description Product description
     * @param _location Initial location
     * @param _batchId Batch identifier
     */
    function registerProduct(
        string memory _name,
        string memory _description,
        string memory _location,
        string memory _batchId
    ) external onlyAuthorized {
        productCounter++;
        
        products[productCounter] = Product({
            id: productCounter,
            name: _name,
            description: _description,
            manufacturer: msg.sender,
            currentOwner: msg.sender,
            timestamp: block.timestamp,
            status: ProductStatus.Manufactured,
            location: _location,
            batchId: _batchId,
            exists: true
        });

        batchProducts[_batchId].push(productCounter);

        emit ProductRegistered(productCounter, _name, msg.sender, _batchId);
    }

    /**
     * @dev Transfer ownership of a product to another entity
     * @param _productId Product identifier
     * @param _newOwner New owner address
     * @param _newLocation New location of the product
     */
    function transferOwnership(
        uint256 _productId,
        address _newOwner,
        string memory _newLocation
    ) external onlyAuthorized productExists(_productId) {
        require(
            products[_productId].currentOwner == msg.sender,
            "Only current owner can transfer ownership"
        );
        require(_newOwner != address(0), "Invalid new owner address");

        address previousOwner = products[_productId].currentOwner;
        products[_productId].currentOwner = _newOwner;
        products[_productId].location = _newLocation;
        products[_productId].timestamp = block.timestamp;
        products[_productId].status = ProductStatus.InTransit;

        emit OwnershipTransferred(_productId, previousOwner, _newOwner, _newLocation);
    }

    /**
     * @dev Update the status and location of a product
     * @param _productId Product identifier
     * @param _status New product status
     * @param _location New location
     */
    function updateProductStatus(
        uint256 _productId,
        ProductStatus _status,
        string memory _location
    ) external onlyAuthorized productExists(_productId) {
        require(
            products[_productId].currentOwner == msg.sender,
            "Only current owner can update status"
        );

        products[_productId].status = _status;
        products[_productId].location = _location;
        products[_productId].timestamp = block.timestamp;

        emit ProductStatusUpdated(_productId, _status, _location);
    }

    // View functions
    function getProduct(uint256 _productId) 
        external 
        view 
        productExists(_productId) 
        returns (
            uint256 id,
            string memory name,
            string memory description,
            address manufacturer,
            address currentOwner,
            uint256 timestamp,
            ProductStatus status,
            string memory location,
            string memory batchId
        ) 
    {
        Product memory product = products[_productId];
        return (
            product.id,
            product.name,
            product.description,
            product.manufacturer,
            product.currentOwner,
            product.timestamp,
            product.status,
            product.location,
            product.batchId
        );
    }

    function getBatchProducts(string memory _batchId) 
        external 
        view 
        returns (uint256[] memory) 
    {
        return batchProducts[_batchId];
    }

    // Admin functions
    function addAuthorizedEntity(address _entity) external onlyAdmin {
        authorizedEntities[_entity] = true;
    }

    function removeAuthorizedEntity(address _entity) external onlyAdmin {
        authorizedEntities[_entity] = false;
    }
}
