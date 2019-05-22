from seam_carving import SeamCarver

import os



def image_resize_without_mask(filename_input, filename_output, new_height, new_width):
    obj = SeamCarver(filename_input, new_height, new_width)
    obj.save_result(filename_output)


def image_resize_with_mask(filename_input, filename_output, new_height, new_width, filename_mask):
    obj = SeamCarver(filename_input, new_height, new_width, protect_mask=filename_mask)
    obj.save_result(filename_output)


def object_removal(filename_input, filename_output, filename_mask):
    obj = SeamCarver(filename_input, 0, 0, object_mask=filename_mask)
    obj.save_result(filename_output)



"""
Put image in in/images folder and protect or object mask in in/masks folder
Ouput image will be saved to out/images folder with filename_output
"""

folder_in = './'
folder_out = './'

filename_input = 'couple.jpg'
filename_mask = 'mask.jpg'
filename_output = 'obj_removed.jpg'
# new_height = 440
# new_width  = 615

input_image = os.path.join(folder_in, "samples/", filename_input)
input_mask = os.path.join(folder_in, "samples/", filename_mask)
output_image = os.path.join(folder_out, "results/", filename_output)

# image_resize_without_mask(input_image, output_image, new_height, new_width)

# image_resize_with_mask(input_image, output_image, new_height, new_width, input_mask)
object_removal(input_image, output_image, input_mask)
print("end")
