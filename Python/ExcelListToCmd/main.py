#coding:utf-8
import argparse

parser = argparse.ArgumentParser()

parser.add_argument('-v',  '--verbose',   help='select mode', action='store_true')
parser.add_argument('-cd', '--createdir', help='Create Dir Cmd', action='store_true')
parser.add_argument('mul', help='multiply', type=str, nargs=1)

args = parser.parse_args()

if args.createdir:
    print(args.mul[0])