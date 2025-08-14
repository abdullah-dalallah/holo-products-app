# Holo Mobile Coding Challenge: E-commerce App

This repository contains my submission for the Holo Mobile Coding Challenge. The goal is to build a small, polished e-commerce application using Flutter and the **FakeStoreAPI**, with a primary focus on the products functionality.

---

## Project Scope

This application is a mobile e-commerce app with the following core functionalities:

* **Product List:** Displays a list of products from the `/products` endpoint of the FakeStoreAPI. This view shows the product image, title, and price, and it handles various states, including loading and errors.
* **Product Details:** Tapping on a product navigates to a details screen, which includes a description.


---

## Technical Decisions

### Architecture

I'm using a **feature-first** folder structure to maintain a clear separation of concerns. Each major feature, such as `products`, has its own dedicated directory containing all related files (UI, business logic, etc.).

### State Management

The application uses the **Bloc** pattern for state management. This choice provides a clear separation between the presentation layer and the business logic. I will use `Bloc` for more complex event-driven logic, ensuring testability and predictability throughout the app.

### API Integration

The app integrates with the **FakeStoreAPI**, and a dedicated data source layer handles all network requests for the `/products` endpoint, keeping the data-fetching logic separate from the rest of the application.

---

## Getting Started

### Prerequisites

* Flutter SDK
* A connected device or emulator

### Running the App

1.  Clone this repository: `git clone https://github.com/abdullah-dalallah/holo-products-app.git`
2.  Navigate to the project directory: `cd holo_products_app`
3.  Install dependencies: `flutter pub get`
4.  Launch the app: `flutter run`
