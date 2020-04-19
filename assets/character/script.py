
bpy.context.scene.render.filepath = '/home/user/Documents/image.jpg'
bpy.ops.render.render(write_still = True)

bpy.context.object.animation_data.action = bpy.data.action['Idle_Stand']

