void stereo_vision_c(unsigned char *L, unsigned char *R, unsigned char * restrict Disparity_Map, int Search_Range, int Radius)
{

    int i,j,k;
    int ii, jj;
    int Sum;

    for (i=(Height-1)-Radius;i>=0+Radius;i--)		// Loop 1
    {
        for (j=(Width-1)-Radius;j>=0+Radius;j--)	// Loop 2
        {
            int Distance=0;
            int Minimize=100000;

            for (k=0;k<Search_Range;k++)			// Loop 3
            {
                Sum=0;
                if (j-Radius-k>=0)
                {

                    for (ii=-Radius;ii<=+Radius;ii++) // Loop 4 
                    {
                        for (jj=-Radius;jj<=+Radius;jj++)	// Loop 5
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
