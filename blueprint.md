
# Recipe Converter App Blueprint

## Overview

This document outlines the architecture, features, and design of the Recipe Converter Flutter application. The app is a kitchen utility designed to help users easily scale, convert, and understand recipe measurements.

## Core Features

- **Recipe Scaling:** Users can multiply recipe quantities by a given factor (e.g., doubling a recipe with a multiplier of 2, or halving it with 0.5).
- **Unit Conversion:** The app performs conversions between common kitchen volume units.
- **Volume-to-Weight Conversion:** For improved accuracy, the app can convert volume measurements (like cups) to weight measurements (like grams) for a variety of common ingredients.

## Implemented Style, Design, and Features

### Current Version

- **Layout:** The application features a single-screen interface dominated by a Material Design `Card`.
  - The top section of the card contains input fields for quantity, unit, ingredient, and a multiplier.
  - A prominent "Calculate" button triggers the conversion logic.
  - The bottom section, which is scrollable, displays the conversion results, separated by a `Divider`.
- **Input Fields:**
  - **Quantity:** A standard `TextFormField` for the numerical value.
  - **Unit:** A `TextFormField` that accepts common units and their abbreviations (e.g., "tsp" for "teaspoon").
  - **Ingredient:** An optional `TextFormField` to specify the ingredient for weight conversions.
  - **Multiplier:** A `TextFormField` that intelligently accepts both decimals (e.g., "0.5") and fractions (e.g., "1/2").
- **Results Display:**
  - **Volume Results:** Shows the scaled recipe quantity in its original units (in both decimal and fraction form) and in milliliters.
  - **Equivalent Measures:** Displays the scaled quantity in other common volume units (e.g., converting cups to tablespoons and teaspoons).
  - **Weight Conversions:** If an ingredient is specified, this section shows the equivalent weight in grams and ounces.

### Architecture

- **Feature-First Architecture:** The application has been refactored into a feature-first directory structure to improve organization and scalability. All code related to the "Quick Convert" functionality is now located in the `lib/features/quick_convert/` directory.
- **Separation of Concerns:** Within the feature directory, concerns are further separated:
  - **UI Layer (`lib/features/quick_convert/ui/`):** This directory contains all the Flutter widgets responsible for the user interface.
    - `quick_convert_screen.dart`: The main screen widget that acts as a container, managing state and orchestrating the UI.
    - `quick_convert_form.dart`: A dedicated widget for the input form.
    - `quick_convert_results.dart`: A dedicated widget for displaying the results.
  - **Logic Layer (`lib/features/quick_convert/logic/`):** This directory contains the business logic.
    - `quick_convert_logic.dart`: This file contains the `QuickConvertLogic` class, which handles all the mathematical calculations, unit conversions, and weight conversions. It is completely independent of the UI.
- **Data Flow:** The UI (`quick_convert_screen.dart`) collects input from the `quick_convert_form.dart`, passes it to the `QuickConvertLogic` class, receives a `ConversionResult` object, and then updates the `quick_convert_results.dart`.
- **Auto-Scrolling Results:** When a new calculation is performed, the results view automatically scrolls to the top to ensure the user can see the latest results without manual scrolling.

## Current Plan

There are no pending changes. The application is in a stable state with all requested features implemented.
