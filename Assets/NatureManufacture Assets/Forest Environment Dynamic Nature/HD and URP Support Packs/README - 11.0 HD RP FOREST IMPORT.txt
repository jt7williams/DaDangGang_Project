About scene:
We set all plants and grass as tree objects as unity HD RP doesn't support terrain grass systems. 

No grass system affect the performance. That's why number of saved by baching is so huge but...performance at scene should be good anyway. About 60 FPS+
We will change this as soon unity will support terrain grass or something that we could use to build proper scene. (It should be very soon)

BEFORE YOU START:
- you need Unity  2021.0 or higher 
- you need HD SRP pipline 11.0 if you use higher etc custom shaders could not work but seams they should. 
Thats why we provide 11.0 version which seams to work with much higher versions aswell. 
For all higher RP versions please use 11.0 HD RP support pack.

Be patient this tech is so fluid... we coudn't fallow ever beta version

Step 1
	- !!!! IMPORTANT !!!! Find Material section at "Project Settings" --> "HDRP Default Settings" find at the bottom "Default Diffusion Profile Assets"
	and drag and drop our SSS settings diffusion profiles for foliage and water into Diffusion profile list:
		  NM_SSSSettings_Skin_Foliage
		  NM_SSSSettings_Skin_NM Foliage
		  NM_SSSSettings_Skin_NM Foliage Trees
		  NM_SSSSettings_Water_Forest
	Without this foliage, water materials will not become affected by scattering and they will look wrong.
	Open "HDRPMediumQuality" in project settings or "HDRPHighQuality" depends what unity use i your projectas default and:
	- Check if you got Deferred only in Lit Shader mode.
	- Check if contact shadows are turned on
	- LOD Bias to = 1 or 1.5
	- Check i you got screen space occlusion turned on
    - Check i you got screen space global ilumination turned on
	- Check i you got screen reflection and ts transparent turned on

Step 2 Go to project settings and quality and set:
	- Set VSync to don't sync

Step 3 Find "HD RP Forest Demo Scene" and open it.

Step 4 - chose way of movment. Movie track or free movment.
	Chose camera and turn on or off "playable directior" and "animation" or leave free camera movment turned on.

Step 5 - HIT PLAY!:)

About scene construction:
		- There is post process profile: Post Process Volume. Manage post process by scene post process object.
		- There is Sky and Fog Volume object, It's are important like hell because basicly it's core of rendering and light managment.
		- There are Density Volume objects which manage volumetric fog density in forest
		- Prefab wind manage wind speed and direction at the scene

Play with it give us feedback and lern about hd srp power.

