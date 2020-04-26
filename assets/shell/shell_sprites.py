import bpy

def setView( deg ):
    print( "Set view {} degrees".format( deg ) )
    bpy.data.objects['Anchor'].rotation_euler[2] = (deg-90)/180*3.1415
    
def setFrame( frame ):
    print( "Set frame {}".format( frame ) )
    bpy.data.scenes['Scene'].frame_current = frame
    
def setAction( action ):
    print( "Action {}".format( action ) )
    bpy.data.objects['Character_S'].animation_data.action = bpy.data.actions[action]
    bpy.data.objects['MuzzleFlash'].animation_data.action = bpy.data.actions[action]
    bpy.data.objects['Pusher'].animation_data.action = bpy.data.actions[action]
    #bpy.data.objects['Floor'].animation_data.action = bpy.data.actions[action]
    #bpy.data.objects['Shell'].animation_data.action = bpy.data.actions[action]

def renderImage( fname ):
    base_path = 'C:/Users/sbashkirov/projects/iland.git/assets/shell/sprites/'
    full_name = base_path + fname
    print( "Save file {}".format( full_name ) )
    bpy.data.scenes['Scene'].render.filepath = full_name
    bpy.ops.render.render( write_still=True )
    print( "done" )
    
def renderSprites():
    # Make transparent packground
    bpy.data.scenes['Scene'].render.image_settings.color_mode = 'RGBA'
    bpy.data.scenes['Scene'].cycles.film_transparent = True
    print( "Rendering sprites" )
    angles = [0, 45, 90, 135, 180, 225, 270, 315]
    #angles = [0]
    actions = [{'name': 'Shell_00', 'frames': [1, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240]}, \
               {'name': 'Shell_01', 'frames': [1, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240]}, \
               {'name': 'Shell_02', 'frames': [1, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220, 230, 240]}, ]
    action = actions[2]
    act_name = action['name']
    act_frames = action['frames']
    for angle in angles:
        setView( angle )
        prefix = "{}_{:03d}".format( act_name, angle )
        for i, frame in enumerate( act_frames ):
            fname = "{}_{:01d}.png".format(prefix, i)
            setFrame( frame )
            renderImage( fname )

    print( "All done" )


def export_sprites():
    #setView( 0 )
    #setFrame( 1 )
    #setAction('Walk')
    renderSprites()

def main():
    for ob in bpy.data.objects:
        print(ob)

#main()
export_sprites()