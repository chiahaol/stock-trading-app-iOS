//
//  ToastView.swift
//  StockTrading
//
//  Created by Jason Liu on 5/4/22.
//

import SwiftUI

struct Toast<Presenting>: View where Presenting: View {

    /// The binding that decides the appropriate drawing in the body.
    @Binding var isShowing: Bool
    /// The view that will be "presenting" this toast
    let presenting: () -> Presenting
    /// The text to show
    let text: Text

    var body: some View {

        GeometryReader { geometry in
            ZStack {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        self.presenting()
                        Spacer()
                    }
                    Spacer()
                }
                
                if isShowing == true {
                    VStack(alignment: .center) {
                        Spacer()
                        self.text
                            .frame(width: geometry.size.width / 1.3, height: 60.0)
                            .font(.subheadline)
                            .background(.gray)
                            .foregroundColor(.white)
                            .cornerRadius(40)
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                          withAnimation {
                            self.isShowing = false
                          }
                        }
                    }
                }
            }
        }

    }

}


extension View {

    func toast(isShowing: Binding<Bool>, text: Text) -> some View {
        Toast(isShowing: isShowing,
              presenting: { self },
              text: text)
    }

}
