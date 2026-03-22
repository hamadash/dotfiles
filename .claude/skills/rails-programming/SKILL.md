---
name: rails-programming
description: Rails Way に則った実装を行うためのガイドライン。機能実装・レイヤー設計・アーキテクチャの判断をする際に参照する。
version: 1.0.0
---

## Rails Guidelines

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

