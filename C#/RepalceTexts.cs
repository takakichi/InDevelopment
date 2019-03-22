
using System;
using System.IO;

class Program {
    static void Main( string[] args ) {
        TextReader readtext;
        string s = String.Empty;
        string searchString = String.Empty;     // 置き換え前の文字列
        string changedString = String.Empty;     // 置き換え後の文字列

        if ( args.Length == 1 ) {
            // 標準入力から置換元テキストを取得する
            readtext = Console.In;
        } else {
            Console.WriteLine("ReplaceTexts version 1.00");
            return false;
        }
        s = readtext.ReadToEnd();
        s.Replace(searchString, changedString)
    }
}
