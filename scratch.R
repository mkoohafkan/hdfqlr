fpath = "C:/TESTING/Sediment Diversion/NoWeirs.p11/NoWeirs.p11.hdf"


path = "Geometry/Cross Sections/Bank Stations"



read_dataset(fpath, path)

devtools::load_all()
fpath = "C:/TESTING/Sediment Diversion/NoWeirs.p11/NoWeirs.p11.hdf"
use_file(fpath)
path = "Geometry/Terrain Filename"


path = "Plan Data/Plan Parameters/1D Methodology"


get_data(path)


get_dimension(path)
get_dataset(path)


path = "Geometry/Cross Sections/Attributes"
get_type(path)

path = "Geometry/Cross Sections/Attributes"
get_type(path)


close_file(fpath)


get_type(att)






setwd("C:/repository/hdfqlr")
devtools::load_all()
hdfql_execute("CREATE FILE my_file.hdf")
hdfql_execute("USE FILE my_file.hdf")
hdfql_execute("CREATE GROUP base")
hdfql_execute("CREATE ATTRIBUTE base/test AS VARCHAR DEFAULT foo")
hdfql_execute("CLOSE FILE my_file.hdf")

hdfql_execute("USE FILE my_file.hdf")
hdfql_execute("SELECT FROM ATTRIBUTE base/test INTO FILE test.txt")




path = "base/test"

get_dimension(path)
get_size(path)
get_data(path)