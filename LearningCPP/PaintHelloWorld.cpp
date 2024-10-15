// using windows api to code my own Text Editor
// this function will use 0s and 1s to draw "Hello World" on the 'startup' screen

void PaintHelloWorld(HDC hdc) {
  const wchar_t* symbol1 = L"0";
  const wchar_t* symbol2 = L"1";

  // size of size_t != size of int
  // casting size_t to int will ignore precision loss warning
  const int symbolLength = static_cast<int>(wcslen(symbol1));
  const int spaceBetweenCellX = 8;
  const int spaceBetweenCellY = 16;
  
  // these change dynamically
  int originOffsetX = 25;
  int originOffsetY = 60;
  int startPaintHeight = 0;
  int startPaintWidth = 0;

  // to alternate between symbols to produce a cool 'binary hack' effect
  std::default_random_engine generator;
  std::uniform_int_distribution<int> distribute{ 0, 1 };

  // H
  {
    const int totalHeight = 22;
    const int middleOccupiedHeight = 5;
    const int widthOccupied = 10;
    const int widthEmpty = 19;
    const int totalWidth = widthOccupied + widthEmpty;

    //left upper leg
    for (int x = 0; x < widthOccupied; x++) {
      for (int y = 0; y < totalHeight / 2; y++) {
        const int xDraw = originOffsetX + x * spaceBetweenCellX;
        const int yDraw = originOffsetY + y * spaceBetweenCellY;
        TextOutW(hdc, xDraw, yDraw, (distribute(generator) < 1) ? symbol1 : symbol2, symbolLength);
      }
    }

    //right upper leg
    for (int x = widthEmpty; x < totalWidth; x++) {
      for (int y = 0; y < totalHeight / 2; y++) {
        const int xDraw = originOffsetX + x * spaceBetweenCellX;
        const int yDraw = originOffsetY + y * spaceBetweenCellY;
        TextOutW(hdc, xDraw, yDraw, (distribute(generator) < 1) ? symbol1 : symbol2, symbolLength);
      }
    }

    startPaintWidth = totalWidth;
    startPaintHeight = 10;

    // draw middle part of the H char
    // this time we can occupy all area
    for (int x = 0; x < totalWidth; x++) {
      for (int y = startPaintHeight; y < startPaintHeight + middleOccupiedHeight; y++) {
        const int xDraw = originOffsetX + x * spaceBetweenCellX;
        const int yDraw = originOffsetY + y * spaceBetweenCellY;
        TextOutW(hdc, xDraw, yDraw, (distribute(generator) < 1) ? symbol1 : symbol2, symbolLength);
      }
    }

    startPaintWidth = 0;
    startPaintHeight = middleOccupiedHeight;
    originOffsetY = startPaintHeight + middleOccupiedHeight;

    //left bottom leg
    for (int x = startPaintWidth; x < widthOccupied; x++) {
      for (int y = startPaintHeight; y < startPaintHeight+totalHeight; y++) {
        const int xDraw = originOffsetX + x * spaceBetweenCellX;
        const int yDraw = originOffsetY + y * spaceBetweenCellY;
        TextOutW(hdc, xDraw, yDraw, (distribute(generator) < 1) ? symbol1 : symbol2, symbolLength);
      }
    }

    startPaintWidth = startPaintWidth + widthEmpty;

    //right bottom leg
    for (int x = startPaintWidth; x < startPaintWidth+widthOccupied; x++) {
      for (int y = startPaintHeight; y < startPaintHeight + totalHeight; y++) {
        const int xDraw = originOffsetX + x * spaceBetweenCellX;
        const int yDraw = originOffsetY + y * spaceBetweenCellY;
        TextOutW(hdc, xDraw, yDraw, (distribute(generator) < 1) ? symbol1 : symbol2, symbolLength);
      }
    }
  }
}
