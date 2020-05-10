import bpy

def setFrame( frame ):
    print( "Set frame {}".format( frame ) )
    bpy.data.scenes['Scene'].frame_current = frame
    
def renderImage( fname ):
    base_path = 'C:/Users/sbashkirov/projects/iland.git/assets/medikit/sprites/'
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
    action = {'name': 'Medikit', 'frames': [1, 10, 20, 30, 40, 50, 60, 70]}
    act_name = action['name']
    act_frames = action['frames']
    prefix = act_name
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
