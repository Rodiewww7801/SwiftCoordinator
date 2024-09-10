//
//  CustomShapesListView.swift
//  AugmentedRealitySupervisorIOS
//
//  Created by Rodion Hladchenko on 05.09.2024.
//

import SwiftUI

protocol CustomShapesViewDelegate: AnyObject {
    func presentTriangle()
    func presentStar()
    func presentTower()
}

struct CustomShapesView: View {
    var delelgate: CustomShapesViewDelegate?
    @StateObject var viewModel = ViewModel()

    var body: some View {
        List {
            Button {
                viewModel.didTapTriangle()
            } label: {
                Text("Triangle")
            }
            Button {
                viewModel.didTapStar()
            } label: {
                Text("Star")
            }
            Button {
                viewModel.didTapTower()
            } label: {
                Text("Tower")
            }
        }
        .onAppear {
            viewModel.delelgate = delelgate
        }
    }
}

extension CustomShapesView {
    @MainActor class ViewModel: ObservableObject {
        weak var delelgate: CustomShapesViewDelegate?

        func didTapTriangle() {
            //coordinator?.handle(CustomShapesAction.triangle)
            delelgate?.presentTriangle()
        }

        func didTapStar() {
            //coordinator?.handle(CustomShapesAction.star)
            delelgate?.presentStar()
        }

        func didTapTower() {
            //coordinator?.handle(CustomShapesAction.tower)
            delelgate?.presentTower()
        }
    }
}

struct CustomShapesView_Previews: PreviewProvider {
    static var previews: some View {
        CustomShapesView()
    }
}
