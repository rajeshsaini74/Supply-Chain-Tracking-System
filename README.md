# Supply Chain Tracking System

A blockchain-based supply chain tracking system that provides transparency and traceability for products throughout their journey from manufacturer to consumer.

## Project Description

The Supply Chain Tracking System is a decentralized application built on blockchain technology that enables transparent tracking of products through various stages of the supply chain. This system allows manufacturers, distributors, retailers, and consumers to verify the authenticity, location, and status of products in real-time.

The smart contract provides immutable record-keeping for product registration, ownership transfers, and status updates, ensuring data integrity and preventing fraud in supply chain operations. Each product is assigned a unique identifier and can be traced back to its origin, providing complete visibility into its journey.

## Project Vision

Our vision is to revolutionize supply chain management by leveraging blockchain technology to create a transparent, secure, and efficient tracking system. We aim to:

- **Eliminate Counterfeiting**: Provide authentic product verification through immutable blockchain records
- **Enhance Consumer Trust**: Enable consumers to verify product origins and journey
- **Improve Compliance**: Help businesses meet regulatory requirements with transparent record-keeping
- **Reduce Fraud**: Prevent unauthorized modifications to product information
- **Enable Quick Recalls**: Facilitate rapid identification and recall of problematic products
- **Support Sustainability**: Track environmental impact and ethical sourcing practices

## Key Features

### 🏭 **Product Registration**
- Register new products with detailed information including name, description, and batch ID
- Assign unique identifiers to each product for lifetime tracking
- Record manufacturer information and initial location

### 🔄 **Ownership Transfer**
- Secure transfer of product ownership between authorized entities
- Automatic status updates during transfers
- Location tracking throughout the supply chain
- Event logging for complete audit trail

### 📊 **Status Management**
- Real-time product status updates (Manufactured, In Transit, Delivered, Recalled)
- Location tracking with timestamp records
- Batch management for grouped products
- Authorized entity management for secure operations

### 🔐 **Security & Authorization**
- Role-based access control for different supply chain participants
- Admin functions for managing authorized entities
- Ownership verification before allowing updates
- Protection against unauthorized modifications

### 🔍 **Transparency & Traceability**
- Complete product history from manufacturing to delivery
- Batch tracking for quality control and recalls
- Public verification of product authenticity
- Immutable record keeping on blockchain

## Technical Architecture

### Smart Contract Features
- **Product Structure**: Comprehensive data model for product information
- **Access Control**: Multi-level authorization system
- **Event Logging**: Detailed event emissions for off-chain tracking
- **Batch Management**: Efficient handling of product batches
- **Status Enumeration**: Clear product lifecycle management

### Core Functions
1. **registerProduct()**: Register new products in the supply chain
2. **transferOwnership()**: Transfer product ownership between entities
3. **updateProductStatus()**: Update product status and location information

## Installation & Setup

### Prerequisites
- Node.js (v16 or higher)
- npm or yarn
- Git

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/supply-chain-tracking-system.git
cd supply-chain-tracking-system
```

### 2. Install Dependencies
```bash
npm install
```

### 3. Environment Configuration
Create a `.env` file in the root directory:
```bash
cp .env.example .env
```

Add your private key and other configuration:
```
PRIVATE_KEY=your_private_key_here
ETHERSCAN_API_KEY=your_etherscan_api_key_here
```

### 4. Compile Contracts
```bash
npm run compile
```

### 5. Deploy to Core Testnet 2
```bash
npm run deploy
```

## Usage Examples

### Register a Product
```javascript
await supplyChainTracking.registerProduct(
  "Organic Coffee Beans",
  "Premium organic coffee from Colombia",
  "Bogota, Colombia",
  "BATCH001"
);
```

### Transfer Ownership
```javascript
await supplyChainTracking.transferOwnership(
  1, // productId
  "0x742d35Cc6634C0532925a3b8D8FA4C479C94c9aC", // new owner
  "Miami Distribution Center"
);
```

### Update Product Status
```javascript
await supplyChainTracking.updateProductStatus(
  1, // productId
  2, // ProductStatus.Delivered
  "Customer Address, Miami"
);
```

## Network Configuration

The project is configured to deploy on Core Testnet 2:
- **RPC URL**: https://rpc.test2.btcs.network
- **Chain ID**: 1115
- **Network Name**: core_testnet

## Testing

Run the test suite:
```bash
npm test
```

## Future Scope

### Phase 1 - Enhanced Features
- **QR Code Integration**: Generate and scan QR codes for easy product tracking
- **Mobile Application**: Consumer-facing mobile app for product verification
- **API Development**: RESTful API for third-party integrations
- **Dashboard Interface**: Web-based dashboard for supply chain participants

### Phase 2 - Advanced Functionality
- **IoT Integration**: Connect with IoT sensors for automated tracking
- **Temperature Monitoring**: Cold chain management for perishable goods
- **Geolocation Services**: GPS tracking integration
- **Multi-chain Support**: Deploy on multiple blockchain networks

### Phase 3 - Enterprise Features
- **Oracle Integration**: Real-world data feeds for automated updates
- **AI/ML Analytics**: Predictive analytics for supply chain optimization
- **Carbon Footprint Tracking**: Environmental impact monitoring
- **Regulatory Compliance**: Automated compliance reporting

### Phase 4 - Ecosystem Expansion
- **Marketplace Integration**: Connect with e-commerce platforms
- **Insurance Integration**: Automated insurance claims processing
- **DeFi Features**: Supply chain financing and payments
- **Governance Token**: Decentralized governance for platform decisions

## Contributing

We welcome contributions to the Supply Chain Tracking System! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support and questions:
- Create an issue on GitHub
- Contact the development team
- Check the documentation wiki

---

**Built with ❤️ using Hardhat, Solidity, and Core Blockchain**
