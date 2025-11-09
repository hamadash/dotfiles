# Common Rules

- 日本語で簡潔かつ丁寧に回答すること。

# Code Style

- プロジェクト固有のルール、命名、設計手法を基準にすること。ただし、それが一般的な原則から外れている場合はコメントで補足すること。
- 認知負荷の高いコードには、適宜コメントで補足すること。

# Rails Guidelines

- 基本的には Rails Way に則ること。
- graphql-ruby を使っている場合、Controller#action と Mutation は似た役割を持つこと。
- Service クラスは基本的に使わないこと。ただし、以下の場合は使用してよい。
  - Controller (Mutation) や Model で表現するには不自然なユースケース。 (DDD でいうアプリケーションサービス)
- Fat Model になりそうなら、クラスの分割を考えること。以下などの手法を用いること。
  - PORO
  - Value Object
  - Custom Validator
- 複数の Model に跨るような処理 (DDD でいうドメインサービス) は、Model に PORO として置くこと。
  - 必要なら ActiveRecord として構わない。
- Fat Controller (graphql-ruby の場合は Query, Mutation) になりそうなら、該当処理を別のレイヤーに移行するのを検討すること。無理に移行しなくてよい。
  - Query (GraphQL ではない Query Object)
  - Repository
  - Model (PORO を使ってイベントモデルを作成)
  - Service (ただし、極力用いずに上述のとおりアプリケーションの用途のみ)

# Development Flow

- 基本的に Test-Driven Development (TDD) を用いること。

    1. テストリストの作成
       - 期待される動作をリストアップする。
       - この時点では、実装の設計判断は混ぜないこと。

    2. テストコードの作成
       - 1 で作成したテストリストから、一つだけ選んでテストコードを作成する。
       - この時点では実装がないため、失敗することを確認する。

    3. テストを成功させる
       - まずは愚直に実装を作成 or 変更して、テストを通す。

    4. 必要に応じてリファクタリング
       - 3 で作成 or 変更した実装を、必要に応じてリファクタリングする。
       - 早すぎる抽象化は避ける。

    5. 2 〜 4 の繰り返し
       - 1 で作成したテストリストが空になるまで、2 〜 4 を繰り返し続ける。
