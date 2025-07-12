# Project Architecture

### High-Level Overview:

This section outlines the high-level architecture of the system, where each major component is defined and its interaction with other components is described. The architecture revolves around a **FastAPI** backend, **Celery workers** for background processing, **CrewAI** for agent-based task execution, and various storage systems.

```
         ┌─────────────┐     ┌───────────────┐     ┌─────────────────┐
         │   FastAPI   │────>│ Celery Worker │────>│ Message Broker  │
         │ (Endpoints) │     │ (with CrewAI) │     │ (with CrewAI)   │
         └─────────────┘     └───────────────┘     └─────────────────┘
                 │                                          │
                 │                                          ▼
                 │                            ┌───────────────────────────┐
                 └───────┐    ┌───────────────│  CrewAI (Agent Execution) │
                         │    │               └───────────────────────────┘
                         │    │                            │
                         ▼    ▼                            ▼
                    ┌──────────────┐                  ┌─────────┐
                    │  PostgreSQL  │                  │  MinIO  │
                    │ (Persistent) │                  │         │
                    └──────────────┘                  └─────────┘
```

### Task Flow:

1. **Client Interaction**:
   - The client sends an HTTP request to **FastAPI**, which contains the task parameters.
   
2. **FastAPI**:
   - FastAPI triggers the task by sending a message to the **Message Broker** (Redis or RabbitMQ).
   
3. **Message Broker**:
   - The broker queues the task, and **Celery Workers** pull the task for execution.

4. **Celery Worker**:
   - The **Celery Worker** starts the task and calls **CrewAI** to initiate agent-based execution.
   - CrewAI runs the agents, who may collaborate and exchange information as part of solving the task.
   
5. **CrewAI**:
   - Once the task is completed, the result is either:
     - Stored in **PostgreSQL** if it's structured data.
     - Stored in **MinIO** if it's a large file or binary data.
   
6. **Result Notification**:
   - The task result is stored and can be fetched by **FastAPI** when the client requests the task status.
   - If real-time updates are required, **WebSocket** or a **message queue** can be used to notify the client immediately when the task is completed.

---

### Benefits of This Architecture:
- **Decoupling**: Using Celery and a message broker allows the system to scale independently. FastAPI only handles HTTP requests, while Celery handles background processing.
- **Scalability**: Both **Celery Workers** and **Message Brokers** can be scaled independently depending on the task volume and processing requirements.
- **Asynchronous Processing**: The entire system is designed for **asynchronous task execution**, preventing FastAPI from being blocked by long-running tasks.
- **Persistence**: Task results are stored in **PostgreSQL**, ensuring that they can be queried later.
- **Storage Flexibility**: Large files or logs can be stored in **MinIO**, providing cost-effective object storage with S3 compatibility.

---

### Considerations:
- **Task Retry Mechanism**: Implementing retries for failed tasks in **Celery** is important to ensure reliability.
- **Monitoring & Logging**: Use tools like **Prometheus** and **Grafana** for monitoring and **Celery Flower** for task monitoring.
- **Real-Time Feedback**: To provide real-time updates to the client, consider integrating **WebSocket** or **long polling** for task progress updates.

---
