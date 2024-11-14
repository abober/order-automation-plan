# Order Automation Platform

This repository contains the architecture documentation and deployment configuration for an order automation platform that integrates multiple external systems and services to streamline order processing and business communication.

## System Overview

The platform consists of several key components:

- **Automation Platform (Make.com)** - Core system for managing and executing automation workflows
- **External Systems Integration** - CRM and OMS system connections
- **Communication Services** - SMS (Twilio), Email (SendGrid) and internal notifications (Slack)
- **Monitoring** - Comprehensive monitoring via Grafana
- **Serverless Logic** - AWS Lambda for specific business logic
- **Database** - Storage for workflow and integration data

## Architecture Documentation

The system architecture is documented using the C4 model and Structurizr. The diagrams show:

- System Context - High-level view of the platform and external systems
- Container View - Detailed components of the automation platform
- Dynamic Views - Key workflows for metrics collection and notifications

## Getting Started

### Prerequisites

- Docker and Docker Compose installed
- `.env` file configured with required variables

### Running the Documentation Server

1. Clone this repository

2. Configure environment variables in `.env`:

3. Start the documentation server:

   ```bash
   docker-compose up -d
   ```

   The documentation server will be available at the address specified in the `.env` file (PORT_DIAGRAMS).
   By default, you can access the documentation at: `http://localhost:8083`
