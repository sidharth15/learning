#define Height 223
#define Width 280

// TODO: optimise this function for better performance
void stereo_vision_c(unsigned char *L, unsigned char *R, unsigned char * restrict Disparity_Map, int Search_Range, int Radius)
{

    int i,j,k;
    int ii, jj;
    int Sum;

    for (i=(Height-1)-Radius;i>=0+Radius;i--)
    {
        for (j=(Width-1)-Radius;j>=0+Radius;j--)
        {
            int Distance=0;
            int Minimize=100000;

            for (k=0;k<Search_Range;k++)
            {
                Sum=0;
                if (j-Radius-k>=0)
                {

                    for (ii=-Radius;ii<=+Radius;ii++)
                    {
                        for (jj=-Radius;jj<=+Radius;jj++)
                        {
                            Sum += abs(L[(i+ii)*Width+(j+jj)]-R[(i+ii)*Width+(j-k+jj)]);

                        }
                    }

                    if (Sum<Minimize)
                    {
                        Minimize=Sum;
                        Distance=k;
                    }
                }
            }
            Disparity_Map[i*Width+j]= Distance;
        }
    }
}
