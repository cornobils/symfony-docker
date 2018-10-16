# Symfony docker

Taken from [Sylius-Standart](https://github.com/Sylius/Sylius-Standard) by [teohhanhui](https://github.com/teohhanhui)

## Installing

0. copy your `composer.json` (or get it for example from 
[Website skeleton](https://github.com/symfony/website-skeleton/blob/master/composer.json)) 
into root directory
0. copy `.env.dist` to `.env` and edit parameters as you need, DB configuration 
works with default values
0. run `docker-compose up -d` 

# Usage
## Installing composer packages

For example, if you want to install LiipImagineBundle, run `docker-compose run --rm php composer require liip/imagine-bundle`, it can ask to execute the recipe, you can press `y`.