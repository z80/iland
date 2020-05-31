
import bpy

for i in range(21):
    ind = i+1
    bpy.data.scenes['Scene'].frame_current = ind
    
    fname = "intro_{:02d}".format( i )
    
    base_path = '~/projects/iland.git/_temp'
    full_name = base_path + fname
    print( "Save file {}".format( full_name ) )
    bpy.data.scenes['Scene'].render.filepath = full_name
    bpy.ops.render.render( write_still=True )
 
 
 