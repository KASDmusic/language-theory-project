import os
import urllib.request
import urllib.parse
import sys

def download(url, dest):
    with urllib.request.urlopen(url) as response:
        html = response.read().decode('utf-8')
        lines = html.split('\n')
        for line in lines:
            if 'href' in line:
                start = line.find('href="') + 6
                end = line.find('"', start)
                filename = line[start:end]
                print(filename)
                if filename != '../':
                    fileurl = urllib.parse.urljoin(url, filename)
                    filepath = os.path.join(dest, filename)
                    print('Downloading', fileurl, 'to', filepath)
                    try:     
                        urllib.request.urlretrieve(fileurl, filepath)
                    except:
                        print('Error downloading', fileurl)
                        continue
                    
if __name__ == '__main__':
    if len(sys.argv) != 3:
        print('Usage: python3 script.py <url> <dest>')
        sys.exit(1)
    url = sys.argv[1]
    dest = sys.argv[2]
    download(url, dest)
