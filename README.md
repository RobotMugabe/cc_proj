# cc_assessment
# Jacques Kovacs
# 22 May 2023

Assessment project for Rank.
A system that allows admins to submit credit card numbers for validation.

## 22 May 2023 - v0.0.1+1
    - Initial project commit

## 22 May 2023 - v0.0.1+2
    - Cleaned project of unnecessary comments.
    - Updated README.md and pubspec.yaml to reflect correct name, description and version number.

## 23 May 2023 - v0.0.2+1
    - Added credit card and country models and created credit card repo.
    - Added initial credit card screen cubit

## 23 May 2023 - v0.0.4+1
    - Added base classes for models and repos.
    - Added country repo functionality.
    - Added go router functionality.
    - Added theme using json_theme.
    - Added initial card screen.

## 3 June 2023 - v0.0.8+1
    - Added add card screen.
    - Added validation for new cards.
    - Added added credit card cards on card screen.
    - Added added assets to make cards look like an actual credit card.
    - Added go router navigation back from add card screen.
    - Fixed bugs with country repo.
    - Fixed bugs with CardType enum in fromJson.

## 4 June 2023 - v0.1.0+1
    - Added ban countries screen.
    - Added scan card screen.
    - Fixed validation when data comes from card scan.
    - Fixed bug to do with failed saving new card.
    - Fixed CardType inference (removed regex and did it with if else).
    - Fixed validation error with banned countries.
    - Added unit tests for luhn algorithm and card type inference.
    - Fixed Card Type not being inferred when adding card number manually.