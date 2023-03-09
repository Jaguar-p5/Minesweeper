import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
int NUM_COLS = 8;
int NUM_ROWS = 8;

private MSButton[][] buttons = new MSButton[NUM_ROWS][NUM_COLS]; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    mines = new ArrayList <MSButton>();
    size(400, 400);
    textAlign(CENTER,CENTER);

    // make the manager
    Interactive.make( this );
    for(int i = 0; i < NUM_ROWS; i++){
      for(int j = 0; j < NUM_COLS; j++){
        buttons[i][j] = new MSButton(i, j);
      }
    }
    
    //your code to initialize buttons goes here
    
    
    for(int i = 0; i < 4; i++){
    setMines();
    }
}
public void setMines()
{
  int i = (int)(Math.random() * NUM_ROWS);
  int j = (int)(Math.random() * NUM_COLS);
  if(!mines.contains(buttons[i][j])){
    mines.add(buttons[i][j]);
  }
  else setMines();
}

public void draw ()
{
    background( 0 );
   for(int r = 0; r < NUM_ROWS; r++){
  for(int c = 0; c < NUM_COLS; c++){
    buttons[r][c].show();
  }
    }
    if(isWon()){
    
        displayWinningMessage();}
}
public boolean isWon()
{
for(int r = 0; r < NUM_ROWS; r++){
  for(int c = 0; c < NUM_COLS; c++){
   if( buttons[r][c].clicked  || buttons[r][c].isMine());
   else return false;
  }
    }
    return true;
}
public void displayLosingMessage()
{
       buttons[3][0].setLabel("y");
       buttons[3][1].setLabel("o");
       buttons[3][2].setLabel("u");
       buttons[3][3].setLabel(" ");
       buttons[3][4].setLabel("l");
       buttons[3][5].setLabel("o");
       buttons[3][6].setLabel("s");
       buttons[3][7].setLabel("e");
       for(int r = 0; r < NUM_ROWS; r++){
  for(int c = 0; c < NUM_COLS; c++){
    buttons[r][c].show();
  }
    } 

   for(int i = 0; i < mines.size(); i++){
    mines.get(i).showMine(); 
   }
   noLoop();
}
public void displayWinningMessage()
{
       buttons[3][0].setLabel("y");
       buttons[3][1].setLabel("o");
       buttons[3][2].setLabel("u");
       buttons[3][3].setLabel(" ");
       buttons[3][4].setLabel("w");
       buttons[3][5].setLabel("i");
       buttons[3][6].setLabel("n");
       buttons[3][7].setLabel("!");
       buttons[4][0].setLabel("");
       for(int r = 0; r < NUM_ROWS; r++){
  for(int c = 0; c < NUM_COLS; c++){
    buttons[r][c].show();
  }
    }
       for(int i = 0; i < mines.size(); i++){
    mines.get(i).showMine(); 
   }
    noLoop();
}
public boolean isValid(int r, int c)
{
    if(r < NUM_ROWS  && c < NUM_COLS)
      if(r >= 0 && c >=0)
        return true;
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    
    for(int i = row-1; i <= row+1; i++){
      for(int j = col-1; j <= col+1; j++)
       if(isValid(i, j))
         if(mines.contains(buttons[i][j]))
           if(!(i == row && j == col))
             numMines ++;
    }
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager // TY for not making us deal with this, sounds unpleasant
    public void mousePressed () 
    {
        
        if(mouseButton == RIGHT){
          if(flagged == true){
            flagged = false;
            
          }
          
         else if(flagged == false && clicked == false){
           
           flagged = true;
         }
         
        }
        else{
         
         clicked = true;
         if( mines.contains(buttons[myRow][myCol])){
            displayLosingMessage();}
         
         if(countMines(myRow, myCol) > 0)
           setLabel(countMines(myRow, myCol));
          
         else{
         if(isValid(myRow+1, myCol+1)  && buttons[myRow+1][myCol + 1].clicked == false){
           
           buttons[myRow + 1][myCol + 1].mousePressed();
         }
         
         if(isValid(myRow, myCol+1)  && buttons[myRow][myCol + 1].clicked == false)
           buttons[myRow ][myCol + 1].mousePressed();         
        
         if(isValid(myRow-1, myCol+1)  && buttons[myRow-1][myCol + 1].clicked == false)
           buttons[myRow-1 ][myCol + 1].mousePressed();             
         ////////////////////////////////////////////////////////////      
         if(isValid(myRow, myCol-1)  && buttons[myRow][myCol - 1].clicked == false)
             buttons[myRow ][myCol - 1].mousePressed();         
         if(isValid(myRow+1, myCol-1)  && buttons[myRow+1][myCol - 1].clicked == false)
           buttons[myRow+1 ][myCol - 1].mousePressed();                 
         if(isValid(myRow-1, myCol-1)  && buttons[myRow-1][myCol - 1].clicked == false)
           buttons[myRow-1 ][myCol - 1].mousePressed();                 
          /////////////////////////////////////////////////////////////////              
        
         if(isValid(myRow+1, myCol)  && buttons[myRow+1][myCol].clicked == false)
           buttons[myRow+1 ][myCol ].mousePressed();                 
         if(isValid(myRow-1, myCol)  && buttons[myRow-1][myCol].clicked == false)
           buttons[myRow-1 ][myCol ].mousePressed();                 
                        
        }
        }
        
          
    }
    public void show() 
    {    
        
        if (flagged)
            fill(0);
         else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );
       

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
        public void showMine() 
    {    
        
  
             fill(255,0,0);

       

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public boolean isMine(){ return mines.contains(this);}
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
