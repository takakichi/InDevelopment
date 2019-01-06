
# はじめに

このメモは、VB.NETにおけるコーディングルール(案:書きかけ)です。

# 基本

基本はMSDNのコーディングルール/名前付けガイドラインに従うこと。

[Visual Basic のコーディング規則](https://docs.microsoft.com/ja-jp/dotnet/visual-basic/programming-guide/program-structure/coding-conventions)  
[名前付けのガイドライン](https://docs.microsoft.com/ja-jp/dotnet/standard/design-guidelines/naming-guidelines)

# ネーミングルール

[変数に対するネーミングルール](./naming/variables.md)

# コーディングルール

[基本的なコーディングルール](./coding/basis.md)
[VB.NET独自のコーディングルール](./coding/vbnet.md)

- マジックナンバーについては、原則使用しないこと。  
- 例外処理は、On Error Goto ではなく、 Try ... Catch または Using を使うこと。  
- Dim は、Function/Sub内で使用するのみとすること(定義の曖昧さをなくすため)。  
- 100行(あくまで目安)を越えるような関数を作らないこと。  
- And/Orではなく、できる限り AndAlso/OrElse を使うようにすること。  

# 変数

- 変数名は原則キャメルケース規約とすること。
- 最初の単語以外の各単語の最初の文字が大文字にする。