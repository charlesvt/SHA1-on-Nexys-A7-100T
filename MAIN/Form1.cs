using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO.Ports;
using System.IO;
using System.Threading;
using System.Globalization;

namespace Serial
{
    public partial class Padding : Form
    {
        public Padding()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            listBox1.Items.Clear();
            listBox2.Items.Clear();
            //INPUT
            string input;
            input = textBox1.Text;
            int input_length = textBox1.Text.Length;

            if (textBox1.Text == "")
            {
                MessageBox.Show("The input you have entered is invalid. Please try again!");
                textBox1.Text = "";
                textBox1.Focus();
            }
            else
            {
                //CONVERT TO ASCII
                string ascii = "";
                foreach (char c in input)
                {
                    int unicode = c;
                    string ascii_tmp = Convert.ToString(unicode, 16);
                    ascii = ascii + ascii_tmp;
                }

                //CONVERT TO BINARY
                string bin_tmp1 = "";

                for (int i = 0; i < ascii.Length; i++)
                {
                    int hex_tmp = CharUnicodeInfo.GetDecimalDigitValue(ascii[i]);
                    string hex_str = Convert.ToString(hex_tmp, 2);
                    if (hex_str.Length == 1)
                        bin_tmp1 = bin_tmp1 + "000" + Convert.ToString(hex_tmp, 2);
                    else if (hex_str.Length == 2)
                        bin_tmp1 = bin_tmp1 + "00" + Convert.ToString(hex_tmp, 2);
                    else if (hex_str.Length == 3)
                        bin_tmp1 = bin_tmp1 + "0" + Convert.ToString(hex_tmp, 2);
                    else
                        bin_tmp1 = bin_tmp1 + Convert.ToString(hex_tmp, 2);
                }

                //NUMBER OF BITS
                int length0;
                int length1;
                int k;
                length0 = (input_length * 8);
                length1 = length0 + 1;
                k = 448 - length1;

                //PAD ZEROES
                for (int j = 0; j <= k; j++)
                {
                    bin_tmp1 = bin_tmp1 + "0";
                }

                //SIZE
                string size = Convert.ToString(length0, 2);
                int size_length = size.Length;
                int l_k = 64 - size_length;

                for (int i = 0; i < l_k; i++)
                {
                    bin_tmp1 = bin_tmp1 + "0";
                }

                for (int i = 0; i < size_length; i++)
                {
                    bin_tmp1 = bin_tmp1 + size[i];
                }

                string line_tmp = "";
                int counter0 = 0;
                for (int i = 0; i < 16; i++)
                {
                    line_tmp = "";
                    for (int j = 0; j < 32; j++)
                    {
                        line_tmp = line_tmp + bin_tmp1[counter0];
                        counter0++;
                    }
                    listBox1.Items.Add(line_tmp);
                }
                
                string hex_out = BinaryStringToHexString(bin_tmp1);

                int counter1 = 0;
                for (int i = 0; i < 16; i++)
                {
                    line_tmp = "";
                    for (int j = 0; j < 8; j++)
                    {
                        line_tmp = line_tmp + hex_out[counter1];
                        counter1++;
                    }
                    listBox2.Items.Add(line_tmp);
                }

                int numOfBytes = bin_tmp1.Length / 8;
                byte[] bytes = new byte[numOfBytes];
                for (int i = 0; i < numOfBytes; ++i)
                {
                    bytes[i] = Convert.ToByte(bin_tmp1.Substring(8 * i, 8), 2);
                }

                serialPort1.Open();
                serialPort1.Write(bytes,0,64);
                serialPort1.Close();

            }

        }

        public static string BinaryStringToHexString(string binary)
        {
            StringBuilder result = new StringBuilder(binary.Length / 8 + 1);

            // TODO: check all 1's or 0's... Will throw otherwise

            int mod4Len = binary.Length % 8;
            if (mod4Len != 0)
            {
                // pad to length multiple of 8
                binary = binary.PadLeft(((binary.Length / 8) + 1) * 8, '0');
            }

            for (int i = 0; i < binary.Length; i += 8)
            {
                string eightBits = binary.Substring(i, 8);
                result.AppendFormat("{0:X2}", Convert.ToByte(eightBits, 2));
            }

            return result.ToString();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            textBox1.Text = "";
            listBox1.Items.Clear();
            listBox2.Items.Clear();
        }
    }
}
