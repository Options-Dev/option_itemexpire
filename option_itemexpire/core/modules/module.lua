--[[
  ░█████╗░██████╗░████████╗██╗░█████╗░███╗░░██╗███████╗ ██████╗░███████╗██╗░░░██╗███████╗██╗░░░░░░█████╗░██████╗░███████╗██████╗░
  ██╔══██╗██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║██╔════╝ ██╔══██╗██╔════╝██║░░░██║██╔════╝██║░░░░░██╔══██╗██╔══██╗██╔════╝██╔══██╗
  ██║░░██║██████╔╝░░░██║░░░██║██║░░██║██╔██╗██║█████╗░░ ██║░░██║█████╗░░╚██╗░██╔╝█████╗░░██║░░░░░██║░░██║██████╔╝█████╗░░██████╔╝
  ██║░░██║██╔═══╝░░░░██║░░░██║██║░░██║██║╚████║██╔══╝░░ ██║░░██║██╔══╝░░░╚████╔╝░██╔══╝░░██║░░░░░██║░░██║██╔═══╝░██╔══╝░░██╔══██╗
  ╚█████╔╝██║░░░░░░░░██║░░░██║╚█████╔╝██║░╚███║███████╗ ██████╔╝███████╗░░╚██╔╝░░███████╗███████╗╚█████╔╝██║░░░░░███████╗██║░░██║
  ░╚════╝░╚═╝░░░░░░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝╚══════╝ ╚═════╝░╚══════╝░░░╚═╝░░░╚══════╝╚══════╝░╚════╝░╚═╝░░░░░╚══════╝╚═╝░░╚═╝
  THANK FOR SUPPORT | DISCORD: https://discord.gg/4qvynScvey | FACEBOOK: https://www.facebook.com/profile.php?id=100088344682775
]]

GetName = function(EVENT)                                                                 
    return (GetCurrentResourceName()..':'..EVENT)
end;

Regis = function(REGIS, EVENT, FUNCTION)                                             
    if REGIS then                                                                      
        RegisterNetEvent(EVENT)                                                            
    end                                                                                    
    AddEventHandler(EVENT, FUNCTION)                                                     
end;

RegisFont = function(FONT)                                                                 
    RegisterFontFile(FONT)                                                            
    return RegisterFontId(FONT)                                                            
end;

RegisNUI = function(EVENT, FUNCTION)    
    RegisterNUICallback(EVENT, FUNCTION)
end


ApplySkin = function(EntityModel, EntitySkin)
    SetPedHeadBlendData			(EntityModel,           EntitySkin['face'],             (EntitySkin['face']), EntitySkin['face'], EntitySkin['skin'], EntitySkin['skin'], EntitySkin['skin'], 1.0, 1.0, 1.0, true)
    SetPedHairColor				(EntityModel,           EntitySkin['hair_color_1'],		(EntitySkin['hair_color_2']))					-- [@ สีผม]
    SetPedHeadOverlay			(EntityModel, 3,		EntitySkin['age_1'],			(EntitySkin['age_2'] / 10) + 0.0)			    -- [@ อายุ + ความทึบ]
    SetPedHeadOverlay			(EntityModel, 1,		EntitySkin['beard_1'],			(EntitySkin['beard_2'] / 10) + 0.0)			    -- [@ เครา + ความทึบ]
    SetPedEyeColor				(EntityModel,			EntitySkin['eye_color'], 0, 1)												    -- [@ สีตา]
    SetPedHeadOverlay			(EntityModel, 2,		EntitySkin['eyebrows_1'],		(EntitySkin['eyebrows_2'] / 10) + 0.0)		    -- [@ คิ้ว + ความทึบ]
    SetPedHeadOverlay			(EntityModel, 4,		EntitySkin['makeup_1'],			(EntitySkin['makeup_2'] / 10) + 0.0)		    -- [@ เมคอัพ + ความทึบ]
    SetPedHeadOverlay			(EntityModel, 8,		EntitySkin['lipstick_1'],		(EntitySkin['lipstick_2'] / 10) + 0.0)		    -- [@ ลิปสติก + ความทึบ]
    SetPedComponentVariation	(EntityModel, 2,		EntitySkin['hair_1'],			(EntitySkin['hair_2']), 2)					    -- [@ ผม]
    SetPedHeadOverlayColor		(EntityModel, 1, 1,	    EntitySkin['beard_3'],			(EntitySkin['beard_4']))					    -- [@ เคราสี]
    SetPedHeadOverlayColor		(EntityModel, 2, 1,	    EntitySkin['eyebrows_3'],		(EntitySkin['eyebrows_4']))					    -- [@ สีคิ้ว]
    SetPedHeadOverlayColor		(EntityModel, 4, 1,	    EntitySkin['makeup_3'],			(EntitySkin['makeup_4']))					    -- [@ สีแต่งหน้า]
    SetPedHeadOverlayColor		(EntityModel, 8, 1,	    EntitySkin['lipstick_3'],		(EntitySkin['lipstick_4']))					    -- [@ สีลิปสติก]
    SetPedHeadOverlay			(EntityModel, 5,		EntitySkin['blush_1'],			(EntitySkin['blush_2'] / 10) + 0.0)			    -- [@ บลัช + ความทึบ]
    SetPedHeadOverlayColor		(EntityModel, 5, 2,	    EntitySkin['blush_3'])                                                          -- [@ บลัช คัลเลอร์]
    SetPedHeadOverlay			(EntityModel, 6,		EntitySkin['complexion_1'],		(EntitySkin['complexion_2'] / 10) + 0.0)	    -- [@ ผิวหน้า + ความทึบ ]
    SetPedHeadOverlay			(EntityModel, 9,		EntitySkin['moles_1'],			(EntitySkin['moles_2'] / 10) + 0.0)			    -- [@ ไฝ/กระ + ความทึบ]
    SetPedHeadOverlay			(EntityModel, 10,		EntitySkin['chest_1'],			(EntitySkin['chest_2'] / 10) + 0.0)			    -- [@ ขนหน้าอก + ความทึบ]
    SetPedHeadOverlayColor		(EntityModel, 10, 1,	EntitySkin['chest_3'])														    -- [@ สีลำตัว]

    if EntitySkin['ears_1'] == -1 then
        ClearPedProp(EntityModel, 2)
    else
        SetPedPropIndex			(EntityModel, 2,		EntitySkin['ears_1'],			EntitySkin['ears_2'], 2)						-- [@ Ears Accessories]
    end

    SetPedComponentVariation	(EntityModel, 8,		EntitySkin['tshirt_1'],			EntitySkin['tshirt_2'], 2)					    -- [@ Tshirt]
    SetPedComponentVariation	(EntityModel, 11,		EntitySkin['torso_1'],			EntitySkin['torso_2'], 2)					    -- [@ torso parts]
    SetPedComponentVariation	(EntityModel, 3,		EntitySkin['arms'],				EntitySkin['arms_2'], 2)						-- [@ Amrs]
    SetPedComponentVariation	(EntityModel, 10,		EntitySkin['decals_1'],			EntitySkin['decals_2'], 2)					    -- [@ decals]
    SetPedComponentVariation	(EntityModel, 4,		EntitySkin['pants_1'],			EntitySkin['pants_2'], 2)					    -- [@ pants]
    SetPedComponentVariation	(EntityModel, 6,		EntitySkin['shoes_1'],			EntitySkin['shoes_2'], 2)					    -- [@ shoes]
    SetPedComponentVariation	(EntityModel, 1,		EntitySkin['mask_1'],			EntitySkin['mask_2'], 2)						-- [@ mask]
    SetPedComponentVariation	(EntityModel, 9,		EntitySkin['bproof_1'],			EntitySkin['bproof_2'], 2)					    -- [@ bulletproof]
    SetPedComponentVariation	(EntityModel, 7,		EntitySkin['chain_1'],			EntitySkin['chain_2'], 2)					    -- [@ chain]
    SetPedComponentVariation	(EntityModel, 5,		EntitySkin['bags_1'],			EntitySkin['bags_2'], 2)						-- [@ Bag]

    if EntitySkin['helmet_1'] == -1 then
        ClearPedProp(EntityModel, 0)
    else
        SetPedPropIndex			(EntityModel, 0,		EntitySkin['helmet_1'],			EntitySkin['helmet_2'], 2)					    -- [@ Helmet]
    end

    if EntitySkin['glasses_1'] == -1 then
        ClearPedProp(EntityModel, 1)
    else
        SetPedPropIndex			(EntityModel, 1,		EntitySkin['glasses_1'],			EntitySkin['glasses_2'], 2)					-- [# Glasses]
    end

    if EntitySkin['watches_1'] == -1 then
        ClearPedProp(EntityModel, 6)
    else
        SetPedPropIndex			(EntityModel, 6,		EntitySkin['watches_1'],			EntitySkin['watches_2'], 2)					-- [@ Watches]
    end

    if EntitySkin['bracelets_1'] == -1 then
        ClearPedProp(EntityModel,	7)
    else
        SetPedPropIndex			(EntityModel, 7,		EntitySkin['bracelets_1'],		EntitySkin['bracelets_2'], 2)				    -- [@ Bracelets]
    end
    
    SetPedFaceFeature			(EntityModel,			0,								(EntitySkin['nose_width'] / 10) + 0.0)			-- [@ Nose Width]
    SetPedFaceFeature			(EntityModel,			1,								(EntitySkin['nose_peak_hight'] / 10) + 0.0)		-- [@ Nose Peak Height]
    SetPedFaceFeature			(EntityModel,			2,								(EntitySkin['nose_peak_lenght'] / 10) + 0.0)	-- [@ Nose Peak Length]
    SetPedFaceFeature			(EntityModel,			3,								(EntitySkin['nose_bone_high'] / 10) + 0.0)		-- [@ Nose Bone Height]
    SetPedFaceFeature			(EntityModel,			4,								(EntitySkin['nose_peak_lowering'] / 10) + 0.0)	-- [@ Nose Peak Lowering]
    SetPedFaceFeature			(EntityModel,			5,								(EntitySkin['nose_bone_twist'] / 10) + 0.0)		-- [@ Nose Bone Twist]
    SetPedFaceFeature			(EntityModel,			6,								(EntitySkin['eyebrown_high'] / 10) + 0.0)		-- [@ Eyebrow height]
    SetPedFaceFeature			(EntityModel,			7,								(EntitySkin['eyebrown_forward'] / 10) + 0.0)	-- [@ Eyebrow depth]
    SetPedFaceFeature			(EntityModel,			8,								(EntitySkin['cheeks_bone_high'] / 10) + 0.0)	-- [@ Cheekbones Height]
    SetPedFaceFeature			(EntityModel,			9,								(EntitySkin['cheeks_bone_width'] / 10) + 0.0)	-- [@ Cheekbones Width]
    SetPedFaceFeature			(EntityModel,			10,								(EntitySkin['cheeks_width'] / 10) + 0.0)		-- [@ Cheeks Width]
    SetPedFaceFeature			(EntityModel,			11,								(EntitySkin['eyes_openning'] / 10) + 0.0)		-- [@ Eyes squint]
    SetPedFaceFeature			(EntityModel,			12,								(EntitySkin['lips_thickness'] / 10) + 0.0)	    -- [@ Lip Fullness]
    SetPedFaceFeature			(EntityModel,			13,								(EntitySkin['jaw_bone_width'] / 10) + 0.0)		-- [@ Jaw Bone Width]
    SetPedFaceFeature			(EntityModel,			14,								(EntitySkin['jaw_bone_back_lenght'] / 10) + 0.0)-- [@ Jaw Bone Length]
    SetPedFaceFeature			(EntityModel,			15,								(EntitySkin['chimp_bone_lowering'] / 10) + 0.0)	-- [@ Chin Height]
    SetPedFaceFeature			(EntityModel,			16,								(EntitySkin['chimp_bone_lenght'] / 10) + 0.0)	-- [@ Chin Length]
    SetPedFaceFeature			(EntityModel,			17,								(EntitySkin['chimp_bone_width'] / 10) + 0.0)	-- [@ Chin Width]
    SetPedFaceFeature			(EntityModel,			18,								(EntitySkin['chimp_hole'] / 10) + 0.0)			-- [@ Chin Hole Size]
    SetPedFaceFeature			(EntityModel,			19,								(EntitySkin['neck_thikness'] / 10) + 0.0)	    -- [@ Neck Thickness]

end

isLoadedModel = function(model)
	RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end
end