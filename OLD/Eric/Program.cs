using System;

namespace padding
{
    class Program
static void Main(string)
    {
        Console.WriteLine("enter the amount of values you want to hash:");
        int _hash1 = Convert.ToInt32(Console.ReadLine());
        for (int i = 0; i < _hash1; i++)
        {
            Console.WriteLine("enter value for value #%d", value[i])
                int _value = Convert.ToInt32(Console.ReadLine());
            value[i] = _value; //need to convert values to binary
            b_value[i] = _binary(value[i]);
        }
        //NUMBER OF BITS
        int length0;
        int length1;
        int k;
        length0 = (_hash1 * 8);
        length1 = (_hash1 * 8) + 1;
        k = 448 - length1;

        //ZEROS FOR PADDING 
        for (int j = 0; j < k; j++)
        {
            zero[j] = 0;
        }
        //SIZE OF BITS THAT GOES BEHIND THE ZEROS PADDING
        int n = int.Parse(length0);
        for (i = 0; n > 0; i++)
        {
            a[i] = n % 2;                 //a[i] is the array that goes behind the zero padding
            n = n / 2;
        }
        //COMBINING ARRAYS
        int[] big_array = new int[b_value.Length + zero.Length];
        Array.Copy(b_value, big_array, b_value.Length);
        Array.Copy(zero, 0, big_array, b_value.Length, zero.Length);

        int[] bigger_array = new int[big_array.Length + a.Length];
        Array.Copy(big_array, bigger_array, big_array.Length);
        Array.Copy(a, 0, bigger_array, big_array.Length, a.Length);
        //string binary = Convert.ToString(length0,2).PadLeft(64,'0');


    }
}
class to_binary
{
    public int _binary(int array1)
    {
        switch (array1)
        {
            case 0:
                array1 = 0000;
                break;
            case 1:
                array1 = 0001;
                break;
            case 2:
                array1 = 0010;
                break;
            case 3:
                array1 = 0011;
                break;
            case 4:
                array1 = 0100;
                break;
            case 5:
                array1 = 0101;
                break;
            case 6:
                array1 = 0110;
                break;
            case 7:
                array1 = 0111;
                break;
            case 8:
                array1 = 1000;
                break;
            case 9:
                array1 = 1001;
                break;
            case 'A':
                array1 = 1010;
                break;
            case 'B':
                array1 = 1011;
                break;
            case 'C':
                array1 = 1100;
                break;
            case 'D':
                array1 = 1101;
                break;
            case 'E':
                array1 = 1110;
                break;
            case 'F':
                array1 = 1111;
                break;

            default:
                array1 = 0000;
                break;
        }
    }
}
    
    
}
