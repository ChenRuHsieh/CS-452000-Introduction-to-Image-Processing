Please put the target image into "samples" directory, then run the inpaint methods below.
Then, an image will pop out and you can circle the unwanted region with you mouse.
Finally, you'll get your results in "results" directory.

Also, at the beginning of the function, you can modify the arguments to get the different result.

There are 3 functions to inpaint the image, just as the report. And I'll take the image "couple.jpg" for example.

inpaint :
    Directly inpainting, only circle the unwanted parts, and you will get "finename.fileformat" as you result in "results" directory.
    For instance of unwanted part in "couple.jpg", you can circle only the woman in the image.

double_inpaint :
    You should circle the objects first, then the code will generate an image without objects.
    The image pops out once more, this time you can just circle the unwanted part.
    For instance of unwanted part in "couple.jpg", you should circle the couple first, then circle the woman at the second time.

seamcar_inpan :
    You can circle the objects as "double_inpaint". But be careful, you should also modify the "filename_input" in "main.py" to the same
    as your image name, so that the code can operate correctly.