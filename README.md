# maku_plate

fivem script for taking off / putting on plate, uses [ox_inventory](https://github.com/overextended/ox_inventory) for item and [ox_target](https://github.com/overextended/ox_target) for car interaction

### Setup

-   Add new item to `ox_inventory/data/items.lua`

```lua
['vehicle_plate'] = {
    label = 'License plate',
	weight = 1,
	stack = false,
	client = {
		export = 'maku_plate.itemUsage'
	},
},
```

-   Move `assets/vehicle_plate.png` to `ox_inventory/web/images` folder
