//------------------------------------------------------
// module  : Tp4-IFT2425-1.c
// author  : Alexandre Hamila 20181634 et de Ryck Hadrien 20180452
// date    :
// version : 1.0
// language: C++
// note    :
//------------------------------------------------------
//

//------------------------------------------------
// FICHIERS INCLUS -------------------------------
//------------------------------------------------
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <new>
#include <unistd.h>

/************************************************************************/
/* WINDOWS						          	*/
/************************************************************************/
#include <X11/Xutil.h>

Display   *display;
int	  screen_num;
int 	  depth;
Window	  root;
Visual*	  visual;
GC	  gc;

//------------------------------------------------
// DEFINITIONS -----------------------------------
//------------------------------------------------
#define CARRE(X) ((X)*(X))

#define OUTPUT_FILE "Tp4-Img-I.pgm"
#define VIEW_PGM    "xv"
#define DEBUG 0

//-Cst-Modele
#define X_1 0.0
#define Y_1 1.0
#define X_2 -1.0/sqrt(2.0)
#define Y_2 -1.0/2.0
#define X_3 +1.0/sqrt(2.0)
#define Y_3 -1.0/2.0
#define C 0.25
#define R 0.1
#define D 0.3

#define X_1_INI 0.2
#define X_2_INI 0.0
#define X_3_INI -1.6
#define X_4_INI 0.0

//-Cst-Runge-Kutta
#define H            0.0001
#define T_0          0.0
#define T_F         30.0
#define NB_INTERV (T_F-T_0)/H

 //-Cst-Image
#define WIDTH  512
#define HEIGHT 512
#define MAX_X  4.0
#define MAX_Y  4.0
#define EVOL_GRAPH 3000

#define WHITE     255
#define GREYWHITE 230
#define GREY      200
#define GREYDARK  120
#define BLACK       0

//------------------------------------------------
// GLOBAL CST ------------------------------------
//------------------------------------------------
float Xmin=0.0;
float Xmax=0.0;
float Ymin=0.0;
float Ymax=0.0;

float xx_1=((WIDTH/MAX_X)*X_1)+(WIDTH/2);
float yy_1=(-(HEIGHT/MAX_Y)*Y_1)+(HEIGHT/2);
float xx_2=((WIDTH/MAX_X)*X_2)+(WIDTH/2);
float yy_2=(-(HEIGHT/MAX_Y)*Y_2)+(HEIGHT/2);
float xx_3=((WIDTH/MAX_X)*X_3)+(WIDTH/2);
float yy_3=(-(HEIGHT/MAX_Y)*Y_3)+(HEIGHT/2);

/************************************************************************/
/* OPEN_DISPLAY()							*/
/************************************************************************/
int open_display()
{
  if ((display=XOpenDisplay(NULL))==NULL)
   { printf("Connection impossible\n");
     return(-1); }

  else
   { screen_num=DefaultScreen(display);
     visual=DefaultVisual(display,screen_num);
     depth=DefaultDepth(display,screen_num);
     root=RootWindow(display,screen_num);
     return 0; }
}

/************************************************************************/
/* FABRIQUE_WINDOW()							*/
/* Cette fonction cr�e une fenetre X et l'affiche � l'�cran.	        */
/************************************************************************/
Window fabrique_window(char *nom_fen,int x,int y,int width,int height,int zoom)
{
  Window                 win;
  XSizeHints      size_hints;
  XWMHints          wm_hints;
  XClassHint     class_hints;
  XTextProperty  windowName, iconName;

  char *name=nom_fen;

  if(zoom<0) { width/=-zoom; height/=-zoom; }
  if(zoom>0) { width*=zoom;  height*=zoom;  }

  win=XCreateSimpleWindow(display,root,x,y,width,height,1,0,255);

  size_hints.flags=PPosition|PSize|PMinSize;
  size_hints.min_width=width;
  size_hints.min_height=height;

  XStringListToTextProperty(&name,1,&windowName);
  XStringListToTextProperty(&name,1,&iconName);
  wm_hints.initial_state=NormalState;
  wm_hints.input=True;
  wm_hints.flags=StateHint|InputHint;
  class_hints.res_name=nom_fen;
  class_hints.res_class=nom_fen;

  XSetWMProperties(display,win,&windowName,&iconName,
                   NULL,0,&size_hints,&wm_hints,&class_hints);

  gc=XCreateGC(display,win,0,NULL);

  XSelectInput(display,win,ExposureMask|KeyPressMask|ButtonPressMask|
               ButtonReleaseMask|ButtonMotionMask|PointerMotionHintMask|
               StructureNotifyMask);

  XMapWindow(display,win);
  return(win);
}

/****************************************************************************/
/* CREE_XIMAGE()							    */
/* Cr�e une XImage � partir d'un tableau de float                          */
/* L'image peut subir un zoom.						    */
/****************************************************************************/
XImage* cree_Ximage(float** mat,int z,int length,int width)
{
  int lgth,wdth,lig,col,zoom_col,zoom_lig;
  float somme;
  unsigned char	 pix;
  unsigned char* dat;
  XImage* imageX;

  /*Zoom positiv*/
  /*------------*/
  if (z>0)
  {
   lgth=length*z;
   wdth=width*z;

   dat=(unsigned char*)malloc(lgth*(wdth*4)*sizeof(unsigned char));
   if (dat==NULL)
      { printf("Impossible d'allouer de la memoire.");
        exit(-1); }

  for(lig=0;lig<lgth;lig=lig+z) for(col=0;col<wdth;col=col+z)
   {
    pix=(unsigned char)mat[lig/z][col/z];
    for(zoom_lig=0;zoom_lig<z;zoom_lig++) for(zoom_col=0;zoom_col<z;zoom_col++)
      {
       dat[((lig+zoom_lig)*wdth*4)+((4*(col+zoom_col))+0)]=pix;
       dat[((lig+zoom_lig)*wdth*4)+((4*(col+zoom_col))+1)]=pix;
       dat[((lig+zoom_lig)*wdth*4)+((4*(col+zoom_col))+2)]=pix;
       dat[((lig+zoom_lig)*wdth*4)+((4*(col+zoom_col))+3)]=pix;
       }
    }
  } /*--------------------------------------------------------*/

  /*Zoom negatifv*/
  /*------------*/
  else
  {
   z=-z;
   lgth=(length/z);
   wdth=(width/z);

   dat=(unsigned char*)malloc(lgth*(wdth*4)*sizeof(unsigned char));
   if (dat==NULL)
      { printf("Impossible d'allouer de la memoire.");
        exit(-1); }

  for(lig=0;lig<(lgth*z);lig=lig+z) for(col=0;col<(wdth*z);col=col+z)
   {
    somme=0.0;
    for(zoom_lig=0;zoom_lig<z;zoom_lig++) for(zoom_col=0;zoom_col<z;zoom_col++)
     somme+=mat[lig+zoom_lig][col+zoom_col];

     somme/=(z*z);
     dat[((lig/z)*wdth*4)+((4*(col/z))+0)]=(unsigned char)somme;
     dat[((lig/z)*wdth*4)+((4*(col/z))+1)]=(unsigned char)somme;
     dat[((lig/z)*wdth*4)+((4*(col/z))+2)]=(unsigned char)somme;
     dat[((lig/z)*wdth*4)+((4*(col/z))+3)]=(unsigned char)somme;
   }
  } /*--------------------------------------------------------*/

  imageX=XCreateImage(display,visual,depth,ZPixmap,0,(char*)dat,wdth,lgth,16,wdth*4);
  return (imageX);
}

//------------------------------------------------
// FUNCTIONS -------------------------------------
//------------------------------------------------
//-------------------------//
//-- Matrice de Double ----//
//-------------------------//
//---------------------------------------------------------
// Alloue de la memoire pour une matrice 1d de float
//----------------------------------------------------------
float* dmatrix_allocate_1d(int hsize)
 {
  float* matrix;
  matrix=new float[hsize]; return matrix; }

//----------------------------------------------------------
// Alloue de la memoire pour une matrice 2d de float
//----------------------------------------------------------
float** dmatrix_allocate_2d(int vsize,int hsize)
 {
  float** matrix;
  float *imptr;

  matrix=new float*[vsize];
  imptr=new float[(hsize)*(vsize)];
  for(int i=0;i<vsize;i++,imptr+=hsize) matrix[i]=imptr;
  return matrix;
 }

//----------------------------------------------------------
// Libere la memoire de la matrice 1d de float
//----------------------------------------------------------
void free_dmatrix_1d(float* pmat)
{ delete[] pmat; }

//----------------------------------------------------------
// Libere la memoire de la matrice 2d de float
//----------------------------------------------------------
void free_dmatrix_2d(float** pmat)
{ delete[] (pmat[0]);
  delete[] pmat;}

//----------------------------------------------------------
// SaveImagePgm
//----------------------------------------------------------
void SaveImagePgm(char* name,float** mat,int lgth,int wdth)
{
 int i,j;
 char buff[300];
 FILE* fic;

  //--extension--
  strcpy(buff,name);

  //--ouverture fichier--
  fic=fopen(buff,"wb");
    if (fic==NULL)
        { printf("Probleme dans la sauvegarde de %s",buff);
          exit(-1); }
  printf("\n Sauvegarde de %s au format pgm\n",buff);

  //--sauvegarde de l'entete--
  fprintf(fic,"P5");
  fprintf(fic,"\n# IMG Module");
  fprintf(fic,"\n%d %d",wdth,lgth);
  fprintf(fic,"\n255\n");

  //--enregistrement--
  for(i=0;i<lgth;i++) for(j=0;j<wdth;j++)
	fprintf(fic,"%c",(char)mat[i][j]);

  //--fermeture fichier--
  fclose(fic);
}

//------------------------------------------------------------------------
// plot_point
//
// Affiche entre x dans [-MAX_X/2  MAX_X/2]
//               y dans [-MAX_Y/2  MAX_Y/2]
//------------------------------------------------------------------------
void plot_point(float** MatPts,float** MatPict,int NbPts)
{
 int x_co,y_co;
 int i,j,k;

 //Init
 for(i=0;i<HEIGHT;i++) for(j=0;j<WIDTH;j++)  MatPict[i][j]=GREYWHITE;

 for(i=0;i<HEIGHT;i++) for(j=0;j<WIDTH;j++)
   { if ((fabs(i-yy_1)+fabs(j-xx_1))<10) MatPict[i][j]=GREYDARK;
     if ((fabs(i-yy_2)+fabs(j-xx_2))<10) MatPict[i][j]=GREYDARK;
     if ((fabs(i-yy_3)+fabs(j-xx_3))<10) MatPict[i][j]=GREYDARK; }

 //Loop
 for(k=0;k<NbPts;k++)
    { x_co=(int)((WIDTH/MAX_X)*MatPts[k][0]);
      y_co=-(int)((HEIGHT/MAX_Y)*MatPts[k][1]);
      y_co+=(HEIGHT/2);
      x_co+=(WIDTH/2);
      if (DEBUG) printf("[%d::%d]",x_co,y_co);
      if ((x_co<WIDTH)&&(y_co<HEIGHT)&&(x_co>0)&&(y_co>0))
	 MatPict[y_co][x_co]=BLACK;
    }
}

//------------------------------------------------------------------------
// Fill_Pict
//------------------------------------------------------------------------
void Fill_Pict(float** MatPts,float** MatPict,int PtsNumber,int NbPts)
{
 int i,j;
 int x_co,y_co;
 int k,k_Init,k_End;

 //Init
 for(i=0;i<HEIGHT;i++) for(j=0;j<WIDTH;j++)
   { if (MatPict[i][j]!=GREYWHITE) MatPict[i][j]=GREY;
     if ((fabs(i-yy_1)+fabs(j-xx_1))<10) MatPict[i][j]=GREYDARK;
     if ((fabs(i-yy_2)+fabs(j-xx_2))<10) MatPict[i][j]=GREYDARK;
     if ((fabs(i-yy_3)+fabs(j-xx_3))<10) MatPict[i][j]=GREYDARK; }

 //Loop
 k_Init=PtsNumber;
 k_End=(k_Init+EVOL_GRAPH)%NbPts;
 for(k=k_Init;k<k_End;k++)
    { k=(k%NbPts);
      x_co=(int)((WIDTH/MAX_X)*MatPts[k][0]);
      y_co=-(int)((HEIGHT/MAX_Y)*MatPts[k][1]);
      y_co+=(HEIGHT/2);
      x_co+=(WIDTH/2);
      if ((x_co<WIDTH)&&(y_co<HEIGHT)&&(x_co>0)&&(y_co>0))
         MatPict[y_co][x_co]=BLACK; }
}


//------------------------------------------------
// FONCTIONS TPs----------------------------------
//------------------------------------------------
float fx1(double x, double vitX, double y) {
    double f1 = -R*vitX - C*x;
    double d1 = (X_1-x)/pow((X_1-x)*(X_1-x) + (Y_1-y)*(Y_1-y) + D*D, 3.0/2);
    double d2 = (X_2-x)/pow((X_2-x)*(X_2-x) + (Y_2-y)*(Y_2-y) + D*D, 3.0/2);
    double d3 = (X_3-x)/pow((X_3-x)*(X_3-x) + (Y_3-y)*(Y_3-y) + D*D, 3.0/2);
    return f1+d1+d2+d3;
}

float fy1(double y, double vitY, double x) {
    double f1 = -R*vitY - C*y;
    double d1 = (Y_1-y)/pow((X_1-x)*(X_1-x) + (Y_1-y)*(Y_1-y) + D*D, 3.0/2);
    double d2 = (Y_2-y)/pow((X_2-x)*(X_2-x) + (Y_2-y)*(Y_2-y) + D*D, 3.0/2);
    double d3 = (Y_3-y)/pow((X_3-x)*(X_3-x) + (Y_3-y)*(Y_3-y) + D*D, 3.0/2);
    return f1+d1+d2+d3;
}

float RungeKuttaVitX(float x, float y, float vitX){
    float k1 = (H * fx1(x, vitX, y));
    float k2 = (H * fx1(x + H/4.0, vitX + (1.0/4.0)*k1, y));
    float k3 = (H * fx1(x + 3*H/8.0, vitX + (3.0/32.0)*k1 + (9.0/32.0)*k2, y));
    float k4 = (H * fx1(x + 12*H/13.0, vitX + (1932.0/2197.0*k1) - (7200.0/2197.0)*k2 + (7296.0/2197.0)*k3, y));
    float k5 = (H * fx1(x + H, vitX + (439.0/219.0)*k1 - (8.0)*k2 + (3680.0/513.0)*k3 - (845.0/4104.0)*k4, y));
    float k6 = (H * fx1(x + H/2.0, vitX -(8.0/27.0)*k1 + (2.0)*k2 - (3544.0/2565.0)*k3 + (1859.0/4104.0)*k4 - (11.0/40.0)*k5, y));
    return (vitX + (16.0/135.0)*k1 + (6656.0/12825.0)*k3 + (28561.0/56430.0)*k4 - (9.0/50.0)*k5 + (2.0/55.0)*k6);
}
float RungeKuttaVitY(float y, float x, float vitY){
    float k1 = (H * fy1(y, vitY, x));
    float k2 = (H * fy1(y + H/4.0, vitY + (1.0/4.0)*k1, x));
    float k3 = (H * fy1(y + 3*H/8.0, vitY + (3.0/32.0)*k1 + (9.0/32.0)*k2, x));
    float k4 = (H * fy1(y + 12*H/13.0, vitY + (1932.0/2197.0*k1) - (7200.0/2197.0)*k2 + (7296.0/2197.0)*k3, x));
    float k5 = (H * fy1(y + H, vitY + (439.0/219.0)*k1 - (8.0)*k2 + (3680.0/513.0)*k3 - (845.0/4104.0)*k4, x));
    float k6 = (H * fy1(y + H/2.0, vitY -(8.0/27.0)*k1 + (2.0)*k2 - (3544.0/2565.0)*k3 + (1859.0/4104.0)*k4 - (11.0/40.0)*k5, x));
    return (vitY + (16.0/135.0)*k1 + (6656.0/12825.0)*k3 + (28561.0/56430.0)*k4 - (9.0/50.0)*k5 + (2.0/55.0)*k6);
}
float RungeKuttaPosX(float x, float vitX){
    float k1 = (H * (vitX));
    float k2 = (H * (vitX + (1.0/4.0)*k1));
    float k3 = (H * (vitX + (3.0/32.0)*k1 + (9.0/32.0)*k2));
    float k4 = (H * (vitX + (1932.0/2197.0*k1) - (7200.0/2197.0)*k2 + (7296.0/2197.0)*k3));
    float k5 = (H * (vitX + (439.0/219.0)*k1 - (8.0)*k2 + (3680.0/513.0)*k3 - (845.0/4104.0)*k4));
    float k6 = (H * (vitX -(8.0/27.0)*k1 + (2.0)*k2 - (3544.0/2565.0)*k3 + (1859.0/4104.0)*k4 - (11.0/40.0)*k5));
    return (x + (16.0/135.0)*k1 + (6656.0/12825.0)*k3 + (28561.0/56430.0)*k4 - (9.0/50.0)*k5 + (2.0/55.0)*k6);
}
float RungeKuttaPosY(float y, float vitY){
    float k1 = (H * (vitY));
    float k2 = (H * (vitY + (1.0/4.0)*k1));
    float k3 = (H * (vitY + (3.0/32.0)*k1 + (9.0/32.0)*k2));
    float k4 = (H * (vitY + (1932.0/2197.0*k1) - (7200.0/2197.0)*k2 + (7296.0/2197.0)*k3));
    float k5 = (H * (vitY + (439.0/216.0)*k1 - (8.0)*k2 + (3680.0/513.0)*k3 - (845.0/4104.0)*k4));
    float k6 = (H * (vitY -(8.0/27.0)*k1 + (2.0)*k2 - (3544.0/2565.0)*k3 + (1859.0/4104.0)*k4 - (11.0/40.0)*k5));
    return (y + (16.0/135.0)*k1 + (6656.0/12825.0)*k3 + (28561.0/56430.0)*k4 - (9.0/50.0)*k5 + (2.0/55.0)*k6);
}

//----------------------------------------------------------
//----------------------------------------------------------
// MAIN
//----------------------------------------------------------
//----------------------------------------------------------
int main (int argc, char **argv)
{
  int i,j,k;
  int flag_graph;
  int zoom;

  XEvent ev;
  Window win_ppicture;
  XImage *x_ppicture;
  char   nomfen_ppicture[100];
  char BufSystVisu[100];

  //>AllocMemory
  float** MatPict=dmatrix_allocate_2d(HEIGHT,WIDTH);
  float** MatPts=dmatrix_allocate_2d((int)(NB_INTERV),2);

  //>Init
  for(i=0;i<HEIGHT;i++) for(j=0;j<WIDTH;j++) MatPict[i][j]=GREYWHITE;
  for(i=0;i<2;i++) for(j=0;j<(int)(NB_INTERV);j++) MatPts[i][j]=0.0;
  flag_graph=1;
  zoom=1;


  //---------------------------------------------------------------------
  //>Question 1
  //---------------------------------------------------------------------

  //Il faut travailler ici ...et dans > // FONCTIONS TPs

  //Un exemple ou la matrice de points est remplie
  //par une courbe donn� par l'�quation d'en bas... et non pas par
  //la solution de l'�quation diff�rentielle
  float x = X_1_INI;
  float vitX = X_2_INI;
  float y = X_3_INI;
  float vitY = X_4_INI;

  for(k=0;k<(int)(NB_INTERV);k++)
    {
      MatPts[k][0]=(x);
      MatPts[k][1]=(y);

      float newVx = RungeKuttaVitX(x, y, vitX);
      float newVy = RungeKuttaVitY(y, x, vitY);

      float newPx = RungeKuttaPosX(x, vitX);
      float newPy = RungeKuttaPosY(y, vitY);

      x = newPx;
      y = newPy;
      vitX = newVx;
      vitY = newVy;
    }


  //--Fin Question 1-----------------------------------------------------


  //>Affichage des Points dans MatPict
  plot_point(MatPts,MatPict,(int)(NB_INTERV));

  //>Save&Visu de MatPict
  SaveImagePgm((char*)OUTPUT_FILE,MatPict,HEIGHT,WIDTH);
  strcpy(BufSystVisu,VIEW_PGM);
  strcat(BufSystVisu," ");
  strcat(BufSystVisu,OUTPUT_FILE);
  strcat(BufSystVisu," &");
  system(BufSystVisu);

  //>Affiche Statistique
  printf("\n\n Stat:  Xmin=[%.2f] Xmax=[%.2f] Ymin=[%.2f] Ymax=[%.2f]\n",Xmin,Xmax,Ymin,Ymax);


 //--------------------------------------------------------------------------------
 //-------------- visu sous XWINDOW de l'�volution de MatPts ----------------------
 //--------------------------------------------------------------------------------
 if (flag_graph)
 {
 //>Uuverture Session Graphique
 if (open_display()<0) printf(" Impossible d'ouvrir une session graphique");
 sprintf(nomfen_ppicture,"�volution du Graphe");
 win_ppicture=fabrique_window(nomfen_ppicture,10,10,HEIGHT,WIDTH,zoom);
 x_ppicture=cree_Ximage(MatPict,zoom,HEIGHT,WIDTH);

 printf("\n\n Pour quitter,appuyer sur la barre d'espace");
 fflush(stdout);

 //>Boucle Evolution
  for(i=0;i<HEIGHT;i++) for(j=0;j<WIDTH;j++) MatPict[i][j]=GREYWHITE;
  for(k=0;;)
     {
       k=((k+EVOL_GRAPH)%(int)(NB_INTERV));
       Fill_Pict(MatPts,MatPict,k,(int)(NB_INTERV));
       XDestroyImage(x_ppicture);
       x_ppicture=cree_Ximage(MatPict,zoom,HEIGHT,WIDTH);
       XPutImage(display,win_ppicture,gc,x_ppicture,0,0,0,0,x_ppicture->width,x_ppicture->height);
       usleep(10000);  //si votre machine est lente mettre un nombre plus petit
     }
 }

 //>Retour
 printf("\n Fini... \n\n\n");
 return 0;
}




