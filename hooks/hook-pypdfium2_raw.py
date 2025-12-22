# Hook for pypdfium2_raw to include pdfium.dll
from PyInstaller.utils.hooks import collect_data_files, collect_dynamic_libs

# 收集数据文件（包括pdfium.dll）
datas = collect_data_files('pypdfium2_raw')

# 收集动态库
binaries = collect_dynamic_libs('pypdfium2_raw')

