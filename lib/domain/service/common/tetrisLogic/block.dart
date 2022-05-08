import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'sub_block.dart';

enum BlockMovement {
  UP,
  DOWN,
  LEFT,
  RIGHT,
  ROTATE_CLOCKWISE, //時計回り
  ROTATE_COUNTER_CLOCKWISE //反時計回り
}

class Block {
  // 4つの方向（orientationIndex）と
  // 7つのブロック（Tブロック、Lブロックなど）からなる二次元配列
  List<List<SubBlock>> orientations = <SubBlock>[].cast<List<SubBlock>>();

  //座標
  late int x;
  late int y; // int y;
  //ブロックの現在の向き
  int orientationIndex;

  //コンストラクタ（４つの方向のブロック、色、ブロックの現在の向き）
  Block(this.orientations, Color color, this.orientationIndex) {
    // 落とすブロックを最初に表示する座標
    x = 3;
    y = -height - 1; //最初のy座標は負の高さに設定

    this.color = color;
  }

  //ブロックの色をセットする
  set color(Color color) {
    for (var orientation in orientations) {
      for (var subBlock in orientation) {
        //ゲームが進むとブロックがバラバラになるので、
        //サブブロックにも色を持たせておく
        subBlock.color = color;
      }
    }
  }

  //ブロックの色を取得する
  Color get color {
    //最初の向きの最初のサブブロックの色を返す
    return orientations[0][0].color;
  }

  // 現在の向き(orientationIndex)のブロックを取得する
  get subBlocks {
    return orientations[orientationIndex];
  }

  // ブロックの幅を取得
  // ブロックの向きによって幅は異なるので、セッターはない
  get width {
    int maxX = 0;
    // 0からスタートし、ブロックに含まれるサブブロックのx座標をループで読む。
    subBlocks.forEach((subBlock) {
      // 最大値＝ブロックの幅
      if (subBlock.x > maxX) maxX = subBlock.x;
    });
    return maxX + 1; //0からスタートしているので＋1する
  }

  // ブロックの高さを取得
  // ブロックの向きによって幅は異なるので、セッターはない
  get height {
    int maxY = 0;
    subBlocks.forEach((subBlock) {
      if (subBlock.y > maxY) maxY = subBlock.y;
    });
    return maxY + 1;
  }

  //ブロックの動き（上下左右、回転）で座標や方向をセットする
  void move(BlockMovement blockMovement) {
    if (kDebugMode) {
      print(" move ブロック動きセットblockMovement $blockMovement");
      print(" y: $y, x: $x");
    }

    switch (blockMovement) {
      case BlockMovement.UP:
        y -= 1;
        break;
      case BlockMovement.DOWN:
        y += 1;
        break;
      case BlockMovement.LEFT:
        x -= 1;
        break;
      case BlockMovement.RIGHT:
        x += 1;
        break;
      case BlockMovement.ROTATE_CLOCKWISE:
        orientationIndex = ++orientationIndex % 4; //4で割った余り（0,1,2,3）
        break;
      case BlockMovement.ROTATE_COUNTER_CLOCKWISE:
        orientationIndex = (orientationIndex + 3) % 4;
        break;
    }
  }
}

class IBlock extends Block {
  IBlock(int orientationIndex)
      : super([
          [SubBlock(0, 0), SubBlock(0, 1), SubBlock(0, 2), SubBlock(0, 3)],
          [SubBlock(0, 0), SubBlock(1, 0), SubBlock(2, 0), SubBlock(3, 0)],
          [SubBlock(0, 0), SubBlock(0, 1), SubBlock(0, 2), SubBlock(0, 3)],
          [SubBlock(0, 0), SubBlock(1, 0), SubBlock(2, 0), SubBlock(3, 0)],
        ], Colors.red, orientationIndex);
}

class JBlock extends Block {
  JBlock(int orientationIndex)
      : super([
          [SubBlock(1, 0), SubBlock(1, 1), SubBlock(1, 2), SubBlock(0, 2)],
          [SubBlock(0, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(2, 1)],
          [SubBlock(0, 0), SubBlock(1, 0), SubBlock(0, 1), SubBlock(0, 2)],
          [SubBlock(0, 0), SubBlock(1, 0), SubBlock(2, 0), SubBlock(2, 1)],
        ], Colors.yellow, orientationIndex);
}

class LBlock extends Block {
  LBlock(int orientationIndex)
      : super([
          [SubBlock(0, 0), SubBlock(0, 1), SubBlock(0, 2), SubBlock(1, 2)],
          [SubBlock(0, 0), SubBlock(1, 0), SubBlock(2, 0), SubBlock(0, 1)],
          [SubBlock(0, 0), SubBlock(1, 0), SubBlock(1, 1), SubBlock(1, 2)],
          [SubBlock(2, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(2, 1)],
        ], Colors.green, orientationIndex);
}

class OBlock extends Block {
  OBlock(int orientationIndex)
      : super([
          [SubBlock(0, 0), SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1)],
          [SubBlock(0, 0), SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1)],
          [SubBlock(0, 0), SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1)],
          [SubBlock(0, 0), SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1)],
        ], Colors.white, orientationIndex);
}

class TBlock extends Block {
  TBlock(int orientationIndex)
      : super([
          [SubBlock(0, 0), SubBlock(1, 0), SubBlock(2, 0), SubBlock(1, 1)],
          [SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(1, 2)],
          [SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(2, 1)],
          [SubBlock(0, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(0, 2)],
        ], Colors.blue, orientationIndex);
}

class SBlock extends Block {
  SBlock(int orientationIndex)
      : super([
          [SubBlock(1, 0), SubBlock(2, 0), SubBlock(0, 1), SubBlock(1, 1)],
          [SubBlock(0, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(1, 2)],
          [SubBlock(1, 0), SubBlock(2, 0), SubBlock(0, 1), SubBlock(1, 1)],
          [SubBlock(0, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(1, 2)],
        ], Colors.orange, orientationIndex);
}

class ZBlock extends Block {
  ZBlock(int orientationIndex)
      : super([
          [SubBlock(0, 0), SubBlock(1, 0), SubBlock(1, 1), SubBlock(2, 1)],
          [SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(0, 2)],
          [SubBlock(0, 0), SubBlock(1, 0), SubBlock(1, 1), SubBlock(2, 1)],
          [SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(0, 2)],
        ], Colors.cyan, orientationIndex);
}
