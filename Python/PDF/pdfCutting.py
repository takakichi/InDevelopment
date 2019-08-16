#
# 参考 : https://note.nkmk.me/python-pypdf2-pdf-merge-insert-split/
# 
import PyPDF2

#
# split_pdf_per_pages
#
def split_pdf_per_pages( src_filename, dst_foldername, base_filename ):
    src_pdf = PyPDF2.PdfFileReader(src_filename)
    for i in range(src_pdf.numPages):
        dst_pdf = PyPDF2.PdfFileWriter()
        dst_pdf.addPage(src_pdf.getPage(i))
        with open('{}/{}_{:0=4}.pdf'.format( dst_foldername, base_filename, i+1 ), 'wb') as f:
            dst_pdf.write(f)

#
# split_pdf_pages
#
def split_pdf_pages( src_filename, dist_filename, start, pagenum ):
    src_pdf = PyPDF2.PdfFileReader(src_filename)
    dst_pdf = PyPDF2.PdfFileWriter()
    cnt = 0
    while cnt < pagenum :
        dst_pdf.addPage(src_pdf.getPage(start+cnt))
        cnt = cnt + 1
    with open(dist_filename, 'wb') as f:
        dst_pdf.write(f)

if __name__ == '__main__':
    # split_pdf_per_pages('./oreilly-978-4-87311-878-9e.pdf', './cutting', 'perpage')
    split_pdf_pages( './oreilly-978-4-87311-878-9e.pdf', './cutting.pdf', 20, 3)