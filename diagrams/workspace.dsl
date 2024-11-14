workspace "Order automation platform" {
    description "Platform for automating order processing and communication with external systems."
    model {
        user = person "Client User" "User interacting with the system to place and manage orders." "Person"

        admin = person "System Admin" "Administrator responsible for overseeing and managing the automation processes." "Person"

        group "Core Systems" {
            crmSystem = softwareSystem "CRM System" "External CRM system for managing client relationships." "CRM System"
            omsSystem = softwareSystem "OMS System" "External Order Management System with its own database, GUI, and API for order processing." "OMS System"
        }

        group "Communication Services" {
            smsService = softwareSystem "Twilio" "External service for sending SMS notifications." "Twilio"
            emailService = softwareSystem "SendGrid" "External service for sending emails." "SendGrid"
            internalNotification = softwareSystem "Slack" "Service for sending internal notifications." "Slack"
        }

        group "Processing & Monitoring" {
            automationPlatform = softwareSystem "Automation Platform" "Platform for managing and automating business processes." "Make.com" {
                workflowEngine = container "Workflow Engine" "Core engine for executing and managing automation workflows." "Make.com"
                
                integrationHub = container "Integration Hub" "Central hub for managing external system integrations." "Make.com, REST API"
                
                schedulerService = container "Scheduler Service" "Service for managing scheduled and recurring tasks." "Make.com Scheduler"
                
                monitoringService = container "Monitoring Service" "Service for tracking workflow execution and performance." "Make.com Analytics"
            }
            
            database = softwareSystem "Automation Database" "Relational database for storing automation workflows and integration data." "Automation Database"
            serverlessLogic = softwareSystem "AWS Lambda" "Serverless computing service." "AWS Lambda"
            monitoring = softwareSystem "Monitoring System" "System for tracking performance." "Grafana"
        }

        user -> automationPlatform "Interacts with"
        admin -> automationPlatform "Manages workflows on"
        automationPlatform -> crmSystem "Communicates with for customer data"
        automationPlatform -> omsSystem "Communicates with for order processing"
        automationPlatform -> smsService "Sends SMS notifications via"
        automationPlatform -> emailService "Sends emails via"
        automationPlatform -> internalNotification "Sends internal notifications via"
        automationPlatform -> serverlessLogic "Triggers AWS Lambda for specific logic"
        workflowEngine -> database "Reads/Writes workflow data"
        integrationHub -> database "Reads/Writes integration data"
        monitoringService -> monitoring "Sends performance metrics"
        workflowEngine -> integrationHub "Sends integration requests"
        schedulerService -> workflowEngine "Triggers scheduled workflows"
        workflowEngine -> monitoringService "Reports workflow status"
        integrationHub -> crmSystem "Retrieves customer data"
        integrationHub -> omsSystem "Manages orders"
        integrationHub -> smsService "Sends SMS notifications"
        integrationHub -> emailService "Sends emails"
        admin -> monitoring "Views monitoring dashboards"
        smsService -> monitoring "Sends Twilio Insights metrics and logs"
        emailService -> monitoring "Sends SendGrid analytics and delivery stats"
        crmSystem -> monitoring "Sends API usage and performance metrics"
        omsSystem -> monitoring "Sends order processing metrics"
        automationPlatform -> monitoring "Sends Make.com execution metrics"
        serverlessLogic -> monitoring "Sends Lambda execution metrics and logs"
        integrationHub -> internalNotification "Sends internal team notifications to Slack"
        workflowEngine -> internalNotification "Sends workflow failure alerts"
        serverlessLogic -> internalNotification "Sends Lambda execution errors"
        internalNotification -> monitoring "Sends Slack API usage and delivery stats"
    }

    views {
        systemContext automationPlatform {
            include *
            autolayout lr
        }

        container automationPlatform {
            include *
            autolayout lr
        }

        styles {
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Person" {
                shape person
                background #08427b
                color #ffffff
            }
            element "Automation Database" {
                shape cylinder
                background #ff8c42
                color #ffffff
            }
            element "CRM System" {
                shape roundedbox
                background #5f6367
                color #ffffff
            }
            element "OMS System" {
                shape roundedbox
                background #5f6367
                color #ffffff
            }
            element "Twilio" {
                shape roundedbox
                background #5f6367
                color #ffffff
            }
            element "SendGrid" {
                shape roundedbox
                background #5f6367
                color #ffffff
            }
            element "Slack" {
                shape roundedbox
                background #5f6367
                color #ffffff
            }
            element "Make.com" {
                shape roundedbox
                background #3b6978
                color #ffffff
            }
            element "AWS Lambda" {
                shape roundedbox
                background #77c4d3
                color #ffffff
            }
            element "Grafana" {
                shape roundedbox
                background #faae7b
                color #ffffff
            }
        }

        dynamic * "MetricsCollectionFlow" {
            title "External Services Metrics Collection"
            autoLayout
            smsService -> monitoring "1. Twilio Insights data"
            emailService -> monitoring "2. SendGrid analytics"
            automationPlatform -> monitoring "3. Make.com metrics"
            serverlessLogic -> monitoring "4. Lambda metrics (duration, errors, invocations, memory usage, cold starts)"
            internalNotification -> monitoring "5. Slack API usage and delivery stats"
            admin -> monitoring "6. Views consolidated data"
        }

        dynamic * "NotificationFlow" {
            title "Notification Services Flow"
            autoLayout
            automationPlatform -> smsService "1. Sends SMS"
            automationPlatform -> emailService "2. Sends emails"
            automationPlatform -> internalNotification "3. Sends Slack alerts"
            automationPlatform -> internalNotification "4. Reports workflow issues"
        }
    }
}