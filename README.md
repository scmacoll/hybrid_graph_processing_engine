# Hybrid Graph Processing Engine

A prototype graph processing engine that demonstrates the unification of property graphs and triple stores, with built-in fault tolerance for telecom network analysis.

## Overview

This prototype demonstrates a novel approach to graph data management by combining property graphs and triple stores, with particular focus on telecom network topology analysis. The system leverages Gleam's functional paradigm and Erlang's supervision trees for fault tolerance.

## Key Features

### 1. Hybrid Graph Model
- Property graph representation for intuitive network modelling
- Automatic conversion to triple store with relationship reification
- Support for both Cypher and SPARQL queries

### 2. Fault Tolerance
- Erlang-style supervision for resilient query execution
- Graceful error handling and recovery
- Simulated fault scenarios for demonstration

### 3. Network Analysis
- Connected components detection
- Network partition simulation
- Topology verification and recovery confirmation

## Technical Implementation

### Property Graph Model
- Nodes represent network elements (e.g., routers)
- Edges represent physical connections
- Properties capture operational attributes

### Triple Store Integration
- Relationship reification for advanced querying
- Consistent mapping between graph models
- Unified query interface

### Fault Tolerance
- Supervision tree for query execution
- Error recovery mechanisms
- State monitoring and restoration

## Running the Demo

```bash
gleam run
```

### The demo will showcase:

Graph model visualisation in both property and triple store formats
Fault tolerance through supervised query execution
Network topology analysis with simulated failures

## Project Structure

- `property_graph.gleam`: Core property graph implementation
- `triple_store.gleam`: Triple store representation
- `graph_mapper.gleam`: Conversion between graph models
- `connected_components.gleam`: Network topology analysis
- `supervision.gleam`: Fault tolerance implementation
- `query_engine.gleam`: Query processing for both models

## Technical Requirements

- Gleam
- Erlang/OTP