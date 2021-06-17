# Write an array ("data"), of any dimension, to a binary file ("file_path"). Optional keyword arguments ("prec" and "endian") are as in function read_binary.
def write_binary (data, file_path, prec=64, endian='big'):

    import numpy as np

    print(('Writing ' + file_path))

    if isinstance(data, np.ma.MaskedArray):
        # Need to remove the mask
        data = data.data

    dtype = set_dtype(prec, endian)    
    # Make sure data is in the right precision
    data = data.astype(dtype)

    # Write to file
    id = open(file_path, 'w')
    data.tofile(id)
    id.close()

# Helper function for read_binary and write_binary. Given a precision (32 or 64) and endian-ness ('big' or 'little'), construct the python data type string.
def set_dtype (prec, endian):

    if endian == 'big':
        dtype = '>'
    elif endian == 'little':
        dtype = '<'
    else:
        print('Error (set_dtype): invalid endianness')
        sys.exit()
    if prec == 32:
        dtype += 'f4'
    elif prec == 64:
        dtype += 'f8'
    else:
        print('Error (set_dtype): invalid precision')
        sys.exit()
    return dtype
