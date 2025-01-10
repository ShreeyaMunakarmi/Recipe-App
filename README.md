# Recipe App

The Recipe App is a feature-rich mobile application developed using Flutter, designed to help users explore, manage, and discover new recipes. The app emphasizes simplicity and user-friendliness, offering categorized recipe navigation, detailed recipe descriptions, filtering options, and support for light and dark themes.



## Features

- Category Listing: View and navigate through recipe categories.
- Food Details: Detailed view of each food item, including steps, ingredients, and gluten-free status.
- Filtering: Filter recipes by type (vegetarian, gluten-free, etc.).
- Favorites: Mark categories and recipes as favorites for quick access.
- Theming: Support for light and dark modes using Material Design.


## Screens
- CategoryListScreen:
    - Displays a grid of categories with navigation options.
    - Includes a bottom navigation bar for filters and favorites.

- FoodListScreen:
    - Shows a list of recipes for a specific category or filter.

- FoodDetailsScreen:
    - Provides detailed information about a recipe, including images, ingredients, and steps.

- FilterScreen:
    - Allows users to set filters for recipes.
  
- FilterOptions Modal:
    - A modal for selecting quick filter options.
  

## Components 
- CategoryCard:
    - Represents a category with name and favorite status.

- FoodCard:
    - Displays food details like name, type, gluten-free status, and an optional image.

- PillBadge:
    - A badge for highlighting attributes like gluten-free or vegetarian.


## Models
- Category:
    - Represents a recipe category with properties like id, name, and isFavorite.
  
- Food:
    - Represents a recipe with details like name, type, ingredients, steps, and imageUrls.


## API Integration 
- The app interacts with a backend API to fetch categories, recipes, and food details.
- API Endpoints:
    - /foods: Fetch all foods.
    - /categories: Fetch all categories.
    - /categories/:id: Fetch specific category details. 
    - /foods/:id: Fetch specific food details.
- Managed in util/api_util.dart.


## Screenshots

- ![ss0.png](/ScreenShots/ss0.png)

- ![ss1.png](/ScreenShots/ss1.png)

- ![ss2.png](/ScreenShots/ss2.png)

- ![ss3.png](/ScreenShots/ss3.png)

- ![ss4.png](/ScreenShots/ss4.png)

- ![ss5.png](/ScreenShots/ss5.png)

- ![ss6.png](/ScreenShots/ss6.png)

- ![ss7.png](/ScreenShots/ss7.png)

- ![ss8.png](/ScreenShots/ss8.png)




