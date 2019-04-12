-- ranks/ranks.lua

ranks.register("general", {
	prefix = "Gen.",
	--colour = {a = 255, r = 230, g = 5, b = 5},
	strict_privs = true, 
	grant_missing = true, 
	revoke_extra = true,
	privs = {
	    interact = true,
	    shout = true,
	    cmodeswitch = true,
	    teacher = true,
	    fly = true,
	    fast = true,
	    creative = true,
	    rank = true,
	    mpd = true,
		ban = true,
		kick = true,
		robot = true,
		puzzle = true,
	},
})

ranks.register("leutenantgen", {
    prefix = "Lt.Gen.",
    --colour = {a = 255, r = 206, g = 70, b = 28},
	strict_privs = true, 
	grant_missing = true, 
	revoke_extra = true,
    privs = {
	    interact = true,
	    shout = true,
	    cmodeswitch = true,
	    teacher = true,
	    mpd = true,
		ban = true,
		kick = true,
        robot = true,
		puzzle = true,
fast = true,
	},
})

ranks.register("majorgen", {
    prefix = "Maj.Gen.",
    --colour = {a = 255, r = 206, g = 144, b = 28},
	strict_privs = true, 
	grant_missing = true, 
	revoke_extra = true,
    privs = {
	    interact = true,
	    shout = true,
	    cmodeswitch = true,
	    teacher = true,
		ban = true,
		kick = true,
        robot = true,
		puzzle = true,
fast = true,
	},
})

ranks.register("brigadiergen", {
    prefix = "Brig.Gen.",
    --colour = {a = 255, r = 229, g = 172, b = 67},
	strict_privs = true, 
	grant_missing = true, 
	revoke_extra = true,
    privs = {
	    interact = true,
	    shout = true,
	    cmodeswitch = true,
	    creative = true,
	    fly = true,
		kick = true,
        robot = true,
		puzzle = true,
fast = true,
	},
})

ranks.register("colonel", {
	prefix = "Col.",
	--colour = {a = 255, r = 67, g = 210, b = 229},
	strict_privs = true, 
	grant_missing = true, 
	revoke_extra = true,
    privs = {
	    interact = true,
	    shout = true,
	    cmodeswitch = true,
		fly = true,
	    kick = true,
fast = true,
	},
})

ranks.register("captain", {
	prefix = "Capt.",
	--colour = {a = 255, r = 67, g = 140, b = 229},
	strict_privs = true, 
	grant_missing = true, 
	revoke_extra = true,
    privs = {
	    interact = true,
	    shout = true,
	    cmodeswitch = true,
		kick = true,
fast = true,
	},
})

ranks.register("sergeant", {
	prefix = "Sgt.",
	--colour = {a = 255, r = 132, g = 24, b = 175},
	strict_privs = true, 
	grant_missing = true, 
	revoke_extra = true,
    privs = {
	    interact = true,
	    shout = true,
	    student = true,
	    cmodeswitch = true,
		kick = true,
fast = true,
	},
})

ranks.register("corporal", {
	prefix = "Cpl.",
	--colour = {a = 255, r = 190, g = 232, b = 23},
	strict_privs = true, 
	grant_missing = true, 
	revoke_extra = true,
    privs = {
	    interact = true,
	    shout = true,
	    student = true,
		kick = true,
fast = true,
	},
})

ranks.register("private", {
	prefix = "Pte.",
	--colour = {a = 255, r = 23, g = 232, b = 40},
	strict_privs = true, 
	grant_missing = true, 
	revoke_extra = true,
    privs = {
	    interact = true,
	    shout = true,
fast = true,
	},
})
